///
//  PongRunner.swift
//  SwiftReinforce
//
//  Created by Sascha Schramm on 09.07.18.
//  Copyright © 2018 Sascha Schramm. All rights reserved.
//

import Python
import Foundation
import TensorFlow




class Main{
    
     let path = "/Users/\(NSUserName())/miniconda2/envs/gymai/lib/python2.7/site-packages/"
    
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
    
    func runCartPole(){
        
        
        let sys = Python.import("sys")
       
        sys.path.append(path)
        let gym = Python.import("gym")
        let env = gym.make("CartPole-v0")
        
        env.seed(0)
        let runner = CartPoleRunner(env: env,
                                    observationSpace: 80 * 80,
                                    actionSpace: 2,
                                    timesteps: Int(1e6),
                                    learningRate: 0.0002,
                                    discountRate: 0.99,
                                    summaryFrequency: 8,
                                    performanceNumEpisodes: 10,
                                    batchSize: 128)
        runner.run()
        
    }
    
    
    func runPong() {
        
        let sys = Python.import("sys")
        sys.path.append(path)
        let gym = Python.import("gym")
        
        let env = gym.make("Pong-v4")
        // if you see - Thread 1: Fatal error: 'try!' expression unexpectedly raised an error: Python exception: Env Pong-v4 not found (valid versions include ['Pong-v3', 'Pong-v0'])
        /*
         conda create -n gymai  python=2.7.9
         source activate gymai
         pip install --upgrade pip
         pip install "gym[atari]"
         */
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
    
    func run() {
        RandomState.global.seed(with: 0)
        //    runFrozenLake()
            runPong()
//        runCartPole()
    }
}