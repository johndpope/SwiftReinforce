import Foundation
import Python

extension Collection where Index: Comparable {
    subscript(back i: Int) -> Iterator.Element {
        let backBy = i + 1
        return self[self.index(self.endIndex, offsetBy: -backBy)]
    }
}

/*
 
 WARNING - this is a direct port of this code
 - https://github.com/Sheyne/Neural/blob/1b0563a65480448a48b395f74a70a7d949112f42/sympy_test.py#L104
 - intention is to demonstrate python lambda callbacks within swift.
 - for mnist stuff + tensorflow see https://github.com/tensorflow/swift-models/tree/stable/MNIST
 */
protocol NeuralLayer {
    func apply(_ x:PythonObject)->PythonObject
    func back(_ err_in:PythonObject,_ old_in:PythonObject)->(weights:PythonObject,biasGradient:PythonObject,weightGradient:PythonObject)
    func learn(_ i:[NeuralLayer], _ rate:Double)->Bool;
}

class NeuralNet:PythonClass{
    
    func  runNet(){
        importSysPath()
        testBackProp()
    }
    
    func testBackProp(){
        print("---------------------------")
        // back propagation with sympy < 125 lines of code
        let y = sympy.Symbol("y")
        let t = sympy.Symbol("t")
        let sigmoid = 1/(1+sympy.exp(-y))
        let cross_entropy = y * sympy.ln(t)+(1 - y) * sympy.ln(1 - t)
        let cost =  sympy.Pow((y - t),2) / 2
        let args = sympy.Array([y, t])
        
        let costFunc = lambdify.lambdastr(args, cost)
        print("costFunc:",costFunc)
        
        let costP = sympy.diff(cost, y)
        print("costP:",costP)
        
        let costPf = lambdify.lambdastr([y, t],costP)
        //        let costPf = sympy.lambdify([y, t], costP) // this blows up  https://github.com/tensorflow/swift/issues/72
        print("costPF:",costP)
        
        // Mnist sample dataset
        let dataset = Python.import("sklearn.datasets").load_digits()
        let classifier = Python.import("sklearn.svm").LinearSVC()
        var (xTrain, xTest, yTrain, yTest) = Python.import("sklearn.model_selection").train_test_split(dataset["data"], dataset["target"]).tuple4
        
        var yHot = numpy.zeros(yTrain.count)//
        print("yHot:",yHot)
        for y in yTrain{
            let hot = oneHot(y)
            print("hot:",hot)
            yHot = np.append(yHot,hot,0)
        }
        print("yHot count:",yHot.count)
        
        
        
        print("xTest:",xTest)
        //       xTest = xTest.reshape(-1, 28*28) ///256 - TODO
        
        
        // 100 neurons
        let  layers:[NeuralLayer] = [
            FullyConnectedLayer(784, 100),
            ActivationLayer(sigmoid, y),
            FullyConnectedLayer(100, 10),
            ActivationLayer(sigmoid, y),
        ]
        
        for _ in 0..<2000{
            let n = xTrain.count
            let rnd = numpy.random.rand(0,n-1)
            let len = Python.len(xTest)
            let range = Python.range(len)
            let s = numpy.array(random.sample(range, 10)) //random sample
          
            print("rnd:",rnd)
            print("xTrain:",xTrain[s])
            print("yHot:",yHot[s])
            
            train(layers, xTrainBatch: xTrain[s],yHotBatch:yHot[s], costPf, 5)
            print((test(xTrain, yTrain), test(xTest, yTest)))
        }
        
    }
    
    func forward(_ layers:[ActivationLayer],_ x: inout PythonObject)->PythonObject{
        for layer in layers{
            x = layer.apply(x)
        }
        return x
    }
    
    
    func train(_ layers:[NeuralLayer], xTrainBatch:PythonObject, yHotBatch:PythonObject,_ costPartial:PythonObject,_ rate:Int = 1){
        var  layersMemories = [NeuralLayer]()
        var results = Array<PythonObject>()
         for( xin, xout) in zip(xTrainBatch,yHotBatch){
              results = [xin]
             for layer in layers{
                let lResults = layer.apply(results[-1])
                results.append(lResults)
                var e = costPartial(xout, results[-1])
                layersMemories =  [NeuralLayer]()
             }
         }
        

    }
    
    
    
    
    func oneHot(_ n:PythonObject)->PythonObject{
        var a = numpy.zeros(10)
        a[n] = 1
        return a
    }
    
    
    func test(_ X:PythonObject,_ Y:PythonObject){
        
        //        let list = forward(layers, x) for x in X{
        //
        //        }
        
        var  predictions = numpy.array([0])
//        var yPredict = numpy.argmax(predictions, axis:1).reshape(-1, 1)
        //        return (yPredict == Y).sum() / Y.count
    }
    
    

    
    
    
    class FullyConnectedLayer:PythonClass,NeuralLayer{
        func learn(_ i: [NeuralLayer], _ rate: Double) -> Bool {
            return true
        }
        
  
        
        
        var weights:PythonObject!
        var biases:PythonObject!
        
        
        init(_ dim_in:Int, _ dim_out:Int){
            super.init()
            numpy = Python.import("numpy")
            // randomly assign weights and bias used by the layer
            weights = numpy.random.rand(dim_out, dim_in)*2 - 1
            biases = numpy.random.rand(dim_out)*2 - 1
            
        }
        
        func apply(_ x:PythonObject)->PythonObject{
            // apply this layer to the NN
            return self.weights.dot(x) + self.biases
        }
        
        func back(_ err_in:PythonObject,_ old_in:PythonObject)->(weights:PythonObject,biasGradient:PythonObject,weightGradient:PythonObject){
            // to do stochastic gradient descent, we're going to want to remember
            // how much this round wanted to change the weights and biases
            let biasGrad = err_in
            let weightGrad = numpy.outer(err_in, old_in)
            return (self.weights.T.dot(err_in), biasGrad, weightGrad)
        }
        
        
        
        func learn( i:Int,_ rate:Double = 0.1){
            // i is a list of every `(bias_grad, weight_grad)` pair we returned in the batch
            // zip(*i) transposes it into lists of all the `bias_grad`s and `weight_grad`s
            //        var bias_grads, weight_grads = zip(*i)
            //        // here we learn by summerizing everything from backprop
            //        self.biases += rate / len(bias_grads) * sum(bias_grads)
            //        self.weights += rate / len(weight_grads) * sum(weight_grads)
        }
        
    }
    
    
    
    
    class ActivationLayer:PythonClass,NeuralLayer{
        func learn(_ i: [NeuralLayer], _ rate: Double) -> Bool {
            return true
        }
        
        // TODO
        func back(_ err_in: PythonObject, _ old_in: PythonObject) -> (weights: PythonObject, biasGradient: PythonObject, weightGradient: PythonObject) {
            let weights = PythonObject()
            let biasGradient = PythonObject()
            let weightGradient = PythonObject()
            
            return (weights,biasGradient,weightGradient)
        }
        
        
        var activation:PythonObject!
        var activation_f:PythonObject!
        var activation_p:PythonObject!
        var activation_p_f:PythonObject!
        var variable:PythonObject!
        
        init(_ activation:PythonObject,_ variable:PythonObject){
            super.init()
            np = Python.import("numpy")
            numpy = Python.import("numpy")
            math = Python.import("math")
            sympy = Python.import("sympy")
            latex = Python.import("sympy.parsing.latex")
            lambdify = Python.import("sympy.utilities.lambdify")
            self.activation = activation
            self.variable = variable
            self.activation_f = lambdify.lambdastr(variable, activation)
            self.activation_p = sympy.diff(activation, variable)
            self.activation_p_f = lambdify.lambdastr(variable, self.activation_p)
            
        }
        
        func apply(_ x:PythonObject)->PythonObject{
            return self.activation_f(x)
        }
        
        
        func back( err_in:PythonObject, old_in:PythonObject)->PythonObject{
            return err_in * self.activation_p_f(old_in)
        }
        
        
        func learn(_ i:Int,_ rate:Double)->Bool{
            return true
        }
        

        
    }
    
}
