//
//  Conda.swift
//  SwiftReinforce
//
//  Created by Pope, John on 9/21/18.
//  Copyright © 2018 Sascha Schramm. All rights reserved.
//

import Foundation

// if you're using a different environment name
// change this in schema > run > pre-actions
// source activate gymai
let environmentName = "gymai"

extension PythonClass{
    
    func importConda(){
        
        print("INFO - conda python environment:",environmentName)
        let  path = "/Users/\(NSUserName())/miniconda2/envs/\(environmentName)/lib/python2.7/site-packages/"
        sys.path.append(path)
        let  path3 = "/Users/\(NSUserName())/miniconda3/envs/\(environmentName)/lib/python2.7/site-packages/"
        sys.path.append(path3)
        
        print("INFO: adding to sys path \n",path)
        print("INFO: adding to sys path \n ",path3)
    }
}
