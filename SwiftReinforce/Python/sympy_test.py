import sympy
import numpy
import itertools
import random

class FullyConnectedLayer:
	def __init__(self, dim_in, dim_out):
		# randomly assign weights and bias used by the layer
		self.weights = numpy.random.rand(dim_out, dim_in)*2 - 1
		self.biases = numpy.random.rand(dim_out)*2 - 1
	
	def apply(self, x):
		# apply this layer to the NN
		return self.weights.dot(x) + self.biases

	def back(self, err_in, old_in):
		# to do stochastic gradient descent, we're going to want to remember 
		# how much this round wanted to change the weights and biases
		bias_grad = err_in
		weight_grad = numpy.outer(err_in, old_in)
		return self.weights.T.dot(err_in), (bias_grad, weight_grad)

	def learn(self, i, rate=0.1):
		# i is a list of every `(bias_grad, weight_grad)` pair we returned in the batch
		# zip(*i) transposes it into lists of all the `bias_grad`s and `weight_grad`s
		bias_grads, weight_grads = zip(*i)
		# here we learn by summerizing everything from backprop
		self.biases += rate / len(bias_grads) * sum(bias_grads)
		self.weights += rate / len(weight_grads) * sum(weight_grads)


class ActivationLayer:
	def __init__(self, activation, var):
		self.activation = activation
		self.var = var
		self.activation_f = sympy.lambdify(var, activation, "numpy")
		self.activation_p = sympy.diff(activation, var)
		self.activation_p_f = sympy.lambdify(var, self.activation_p, "numpy")

	def apply(self, x):
		return self.activation_f(x)

	def back(self, err_in, old_in):
		return err_in * self.activation_p_f(old_in), None

	def learn(self, i, rate): pass

	def __getstate__(self):
		return (self.activation, self.var)
	
	def __setstate__(self, pair):
		self.__init__(*pair)

def forward(layers, x):
	for layer in layers:
		x = layer.apply(x)
	return x

def train(layers, batch, cost_partial, rate=1):
	layers_memories = []
	for xin, xout in zip(*batch):
		results = [xin]
		for layer in layers:
			results.append(layer.apply(results[-1]))

		e = cost_partial(xout, results[-1])
		layers_memory = []
		for layer, result in reversed(list(zip(layers, results[:-1]))):
			e, memory = layer.back(e, result)
			layers_memory.append(memory)
		layers_memories.append(reversed(layers_memory))

	for layer, layer_memories in zip(layers, zip(*layers_memories)):
		layer.learn(layer_memories, rate=rate)

def one_hot(n):
	a = numpy.zeros(10)
	a[n] = 1
	return a

def test(X, Y):
	predictions = numpy.array([forward(layers, x) for x in X])
	Y_predict = numpy.argmax(predictions, axis=1).reshape(-1, 1)
	return (Y_predict == Y).sum() / len(Y)

if __name__ == "__main__":
	from mnist import load_mnist
	from pickle import dump, load
	import sys

	X, Y = load_mnist('training', path="./mnist")

	X = X.reshape(-1, 28*28)/256
	Y_hot = numpy.array([one_hot(y) for y in Y])

	X_test, Y_test = load_mnist('testing', path="./mnist")
	X_test = X_test.reshape(-1, 28*28)/256

	print("Loaded")

	t = sympy.Symbol("t")
	y = sympy.Symbol("y")

	sigmoid = 1/(1+sympy.exp(-y))
	cross_entropy = y * sympy.ln(t)+(1 - y) * sympy.ln(1 - t)
	cost =  (y - t) ** 2 / 2
	cost_f = sympy.lambdify((y, t), cost, "numpy")
	cost_p = sympy.diff(cost, y)
	cost_p_f = sympy.lambdify((y, t), cost_p, "numpy")

	if len(sys.argv) == 2:
		layers = load(open(sys.argv[1], "rb"))
	else:
		layers = [
			FullyConnectedLayer(784, 100),
			ActivationLayer(sigmoid, y),
			FullyConnectedLayer(100, 10),
			ActivationLayer(sigmoid, y),
			]

	print((test(X, Y), test(X_test, Y_test)))

	try:
		while True:
			for _ in range(2000):
				s = numpy.array(random.sample(range(len(X)), 10))
				train(layers, [X[s], Y_hot[s]], cost_partial=cost_p_f, rate=5)
			print((test(X, Y), test(X_test, Y_test)))
	except KeyboardInterrupt:
		dump(layers, open("run.pickle", "wb"))
