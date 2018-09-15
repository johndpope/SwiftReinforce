//
//  FrozenLakeRunner.swift
//  SwiftReinforce
//
//  Created by Sascha Schramm on 08.07.18.
//  Copyright © 2018 Sascha Schramm. All rights reserved.
//

import Foundation
import Python
import TensorFlow


func - <Element: Hashable>(lhs: [Element], rhs: [Element]) -> [Element]
{
    return Array(Set<Element>(lhs).subtracting(Set<Element>(rhs)))
}

//func divideElements(matrix: Matrix) -> Matrix {
//    return self.combine(matrix, operation: /)
//}
//

class MountainCarRunner {
    var env: PythonObject = []
    var timesteps: Int = 0 
    var observationSpace: Int32 = 6400 // 80*80
    
    // Maps an observation to state
    func  observationToState(_ env:PythonObject,_ observations: [[Float]] )->([Int8],[Int8]){
        
        let envLow: [Float] = Array<Float>(numpyArray: env.observation_space.low)!
        let envHigh: [Float] = Array<Float>(numpyArray: env.observation_space.high)!
        let div: [Float] = Array(repeating:  Float(envLow.count), count: 6400)
        let envDx = ( envHigh - envLow) / div
        let a = Int((observations[0] - envLow[0])/envDx[0])
        let b = Int((observations[1] - envLow[1])/envDx[1])
        return [a , b]
//        return ([0],[0])
    }
    
    
    func run(){
        
        let nStates = 40
        let iterMax = 10000
        
        let initialLr = 1.0 // Learning rate
        let minLr = 0.003
        let gamma = 1.0
        let tMax = 10000
        let eps = 0.02
        
        let np = Python.import("numpy")
        let qTable = np.zeros(nStates, nStates, 3)
        
        
    }
    
    /*
    func runEpisode(env:PythonObject, policy:[[Float]], render:Bool){
        var observation: PythonObject = env.reset()
        
        var observations: [[Float]] = []
        
        var totalReward = 0
        var stepIdx = 0
        for t in 0 ..< timesteps + 1 {
            if render{
                 observations.append(preprocess(observation))
                //            env.render()
                var action:Int32 = 0
                if policy ==  []{
                    action = Int32(env.action_space.sample())!
                }else{
                    let a,b = observationToState(env, observations)
                    action = policy[a][b]
                }
                let obs, reward, done, _ = env.step(action)
                totalReward += gamma << stepIdx * reward
                stepIdx += 1
                if done{
                   break
                } return totalReward
               
                
            }
        }
    }

    

    func preprocess(_ step: PythonObject) -> [Float] {
        let numpyArray: PythonObject = step[35..<195]
        let observation: [UInt8] = Array<UInt8>(numpyArray: numpyArray)!

        var preprocessedImage = [Float](repeating: 0, count: 80 * 80)
        for i in stride(from: 0, to: 160, by: 2) {
            for j in stride(from: 0, to: 160, by: 2) {
                let index = (i * 160 + j)
                let oldIndex = index * 3
                let newIndex = i/2 * 80 + j/2
//                preprocessedImage[newIndex] = transform(observation[oldIndex])
            }
        }
        return preprocessedImage
    }
*/
    
}




    

   
