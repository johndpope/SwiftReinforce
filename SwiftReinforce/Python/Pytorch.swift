//
//  Conda.swift
//  SwiftReinforce
//
//  Created by Pope, John on 9/21/18.
//  Copyright © 2018 Sascha Schramm. All rights reserved.
//

import Foundation
import Python



extension PythonClass{
    
    
    
    func importPytorch(){
        
        print("import keras")
        keras = Python.import("keras") 
        print("import torch")
        torch = Python.import("torch")
    }
    
}
