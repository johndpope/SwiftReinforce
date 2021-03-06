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

//RandomState.global.seed(with: 0)

// WARNING - if you get a crash - check which python - it maybe under miniconda3 or miniconda3!
// N.B. - this branch is using miniconda3 not virtualenv see
// https://github.com/johndpope/SwiftReinforce readme
let  path = "/Users/\(NSUserName())/miniconda3/envs/gymai/lib/python2.7/site-packages/"

func runFrozenLake() {
    let sys = Python.import("sys")
    sys.path.append(path)
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

func runPong() {
   
    let sys = Python.import("sys")
    sys.path.append(path)
    let gym = Python.import("gym")
    let env = gym.make("Pong-v4")
    
    // see here -> https://github.com/johndpope/SwiftReinforce
    
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
//    runMountainCar()
    let sp = SymPy()
    sp.run()
//    let nn = NeuralNet()
//    nn.runNet()
//    let test = PythonClass()
//    test.importSysPath()
    
    
}


main()
