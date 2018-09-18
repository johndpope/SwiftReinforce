//
//  Utilities.swift
//  SwiftReinforce
//
//  Created by Sascha Schramm on 09.07.18.
//  Copyright © 2018 Sascha Schramm. All rights reserved.
//

import Foundation
import TensorFlow
import Python



func discount(rewards: [Float], dones: [Bool], discountRate: Float) -> [Float] {
    var discounted: [Float] = []
    var totalReturn: Float = 0.0
    for (reward, done) in zip(rewards.reversed(), dones.reversed()) {
        if done {
            totalReturn = reward
        } else {
            totalReturn = reward + discountRate * totalReturn
        }
        discounted.append(totalReturn)
    }
    return discounted.reversed()
}

func renderPixels(_ pixels: [UInt8], rows: Int, cols: Int) {
    let sys = Python.import("sys")
    let np = Python.import("numpy")
    sys.path.append(path)
    let image = Python.import("PIL.Image")
    
    let foo = np.array(pixels).reshape([rows,cols])
    let img = image.fromarray(np.uint8(foo))
    img.show()
}

func printPixels(_ pixels:[UInt8], cols:Int, rows: Int) {
    var str = ""
    for i in 0 ..< rows { // row
        for j in 0 ..< cols { // column
            let index = i * cols + j
            str += "\(pixels[index]) "
        }
        str += String("\n")
    }
    print(str)
}
