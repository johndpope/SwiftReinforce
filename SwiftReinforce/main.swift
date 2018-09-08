//
//  main.swift
//  SwiftReinforce
//
//  Created by Sascha Schramm on 05.08.18.
//  Copyright © 2018 Sascha Schramm. All rights reserved.
//

import Foundation
import TensorFlow
import Python


RandomState.global.seed(with: 0)

func runFrozenLake() {
    let gym = Python.import("gym")
    gym.envs.registration.register(id:"FrozenLakeNotSlippery-v0",
                                   entry_point:"gym.envs.toy_text:FrozenLakeEnv",
                                   kwargs: ["is_slippery": false])
    
    let env = gym.make("FrozenLakeNotSlippery-v0")
    env.seed(0)
    
    let runner = FrozenLakeRunner(env: env,
                                  observationSpace: 16,
                                  actionSpace: 4,
                                  timesteps: 20000,
                                  learningRate: 0.1,
                                  discountRate: 0.99,
                                  summaryFrequency: 2000,
                                  performanceNumEpisodes: 100,
                                  batchSize: 16)
    
    let start = DispatchTime.now()
    runner.run()
    let end = DispatchTime.now()
    let time = Double(end.uptimeNanoseconds - start.uptimeNanoseconds)/Double(1_000_000_000)
    print(time)
}


func runTensorflowViaPython(){
    
    let sys = Python.import("sys")
    

    dlopen("_pywrap_tensorflow_internal.so", RTLD_NOW | RTLD_GLOBAL)
    
    let tf = Python.import("tensorflow")
    let np = Python.import("numpy")

    let learningRate = 0.01
    let trainingEpochs = 1000
    let displayStep = 50
    

    
    // Training Data# Train
    let trainX = np.asarray([3.3,4.4,5.5,6.71,6.93,4.168,9.779,6.182,7.59,2.167,
    7.042,10.791,5.313,7.997,5.654,9.27,3.1])
    let trainY = np.asarray([1.7,2.76,2.09,3.19,1.694,1.573,3.366,2.596,2.53,1.221,
    2.827,3.465,1.65,2.904,2.42,2.94,1.3])
    let n = trainX.shape[0]
    
    // tf Graph Input# tf Gr
    let X = tf.placeholder("float")
    let Y = tf.placeholder("float")
    
    // Set model weights
    let W = tf.Variable(3, name:"weight")
    let b = tf.Variable(4, name:"bias")
    
    
    // Construct a linear model# Const
    let pred = tf.add(tf.multiply(X, W), b)
    
    // Mean squared error
    let cost = tf.reduce_sum(tf.pow(pred-Y, 2))/(2*n)
    // Gradient descent
    let optimizer = tf.train.GradientDescentOptimizer(learningRate).minimize(cost)
    
    
    // Initialize the variables (i.e. assign their default value)# Initi
    let initialize = tf.global_variables_initializer()
    
    let sess =  tf.Session()
    sess.run(initialize)
    
    // Fit all training data
    for epoch in 0..<trainingEpochs{
        for (x, y) in zip(trainX, trainY){
            var fd = Dictionary<String,PythonObject.Element>()
            fd["X"] = x
            fd["Y"] = y
            sess.run(optimizer, feed_dict:fd)
        }

        //Display logs per epoch step
        if (epoch+1) % displayStep == 0{
            var fd = Dictionary<String,PythonObject.Element>()
            fd["X"] = trainX
            fd["Y"] = trainY
            let c = sess.run(cost, feed_dict:fd)
//            print("Epoch:", (epoch+1), "cost=", "{:.9f}".format(c), "W=", sess.run(W), "b=", sess.run(b))
        }
    }
    print ("Optimization Finished!")
    var fd = Dictionary<String,PythonObject.Element>()
    fd["X"] = trainX
    fd["Y"] = trainY
    let trainingCost = sess.run(cost, feed_dict:fd)
//    print ("Training cost=", trainingCost, "W=", sess.run(W), "b=", sess.run(b), '\n')
    
}
func runPong() {
   
    let sys = Python.import("sys")
    /*
 conda create -n gymai  python=2.7.9
 source activate gymai
 pip install --upgrade pip
 pip install "gym[atari]"
 */
    let path = "/Users/\(NSUserName())/miniconda2/envs/gymai/lib/python2.7/site-packages/"
    sys.path.append(path)
     let gym = Python.import("gym")
    
    let env = gym.make("Pong-v4")
    env.seed(0)
    
 
    
    let runner = PongRunner(env: env,
                            observationSpace: 80 * 80,
                            actionSpace: 2,
                            timesteps: Int(1e6),
                            learningRate: 0.0002,
                            discountRate: 0.99,
                            summaryFrequency: 40000,
                            performanceNumEpisodes: 10,
                            batchSize: 128)
    runner.run()
}

func main() {
//    runFrozenLake()
//    runPong()
    runTensorflowViaPython()
}

main()
