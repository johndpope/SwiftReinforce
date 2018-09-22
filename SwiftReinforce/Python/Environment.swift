//
//  Conda.swift
//  SwiftReinforce
//
//  Created by Pope, John on 9/21/18.
//  Copyright © 2018 Sascha Schramm. All rights reserved.
//

import Foundation
import Python

// IMPORTANT - if you're using a different environment name
// Schema > Run > Pre-actions - source activate gymai
let environmentName = "gymai"

extension PythonClass{
    
    // N.B. do a source deactivate to ensure base is updated!!!
    /* source deactivate
    ➜   python
    Python 2.7.10 (default, Aug 17 2018, 17:41:52)
    [GCC 4.2.1 Compatible Apple LLVM 10.0.0 (clang-1000.0.42)] on darwin
    Type "help", "copyright", "credits" or "license" for more information.
    >>> import numpy as np
    >>> np.version.version
    '1.8.0rc1' // make sure this is updated. - check sys.path importConda
     
    */
    func importNumpy(){
        np = Python.import("numpy")
        numpy = Python.import("numpy")
        print("INFO: 📦 numpy version - ",np.version.version) // ensure that you use insert path sys.path.insert(0,miniconda-site-package-path)
        
    }
    


    
    func importConda(){
        
        print("INFO: 🐍 conda environment:",environmentName)
        let  path2 = "/Users/\(NSUserName())/miniconda2/envs/\(environmentName)/lib/python2.7/site-packages/"
        sys.path.insert(0,path2)
        let  path3 = "/Users/\(NSUserName())/miniconda3/envs/\(environmentName)/lib/python2.7/site-packages/"
        sys.path.insert(0,path3)
        // N.B. use insert rather than append otherwise ran into problems
        // numpy version    //https://github.com/tensorflow/swift/issues/73 - numpy  1.8.0rc1

        print("INFO: sys path \n",path)


    }
    
    //TODO - test existence of this class - if not alert user to add hard coded path.
    // nb the executal is going to be executed in some temp folder it won't have relative access to this project folder
    func importThisProjectFolder(){
        let  customClassPath = "/Users/admin/Documents/mlWorkspace/SwiftReinforce/SwiftReinforce/Python"
        print("INFO: adding hard coded path to allow access to python class")
        print("(you're  going to want to change this to your pwd of Python folder):")
        print("path:",customClassPath)
        print("\n\n\n")
        sys.path.append(customClassPath)
    }
    
    

    
}
