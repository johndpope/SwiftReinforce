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
    '1.8.0rc1' // make sure this is updated.
     
    */
    func importNumpy(){
        np = Python.import("numpy")
        numpy = Python.import("numpy")
        print("INFO: numpy version - ",np.version.version) // ensure that you use insert path sys.path.insert(0,path3)
        
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
        let  customClassPath = "/Users/jpope/Documents/tensorflowWorkspace/SwiftReinforce/SwiftReinforce/Python"
        print("INFO: adding hard coded path to allow access to python class")
        print("(you're  going to want to change this to your pwd of Python folder):")
        print("path:",customClassPath)
        print("\n\n\n")
        sys.path.append(customClassPath)
    }
    
    
    func importPytorch(){
        
        //            keras = Python.import("keras") // blows up //  code $HOME/.keras/keras.json  tensorflow -> theano / pip install theano - missing cPickle!
        //  0x9 -> numpy-1.15.1
        torch = Python.import("torch") //Fatal error: 'try!' expression unexpectedly raised an error: Python exception: module compiled against API version 0xa but this version of numpy is 0x9: file /usr/local/src/swift-build/swift/stdlib/public/core/ErrorType.swift, line 185 --see
        
        // 0xc -> 12
        // 0xd -> 13
        // 0xd -> 13
        // Fatal error: 'try!' expression unexpectedly raised an error: Python exception: module compiled against API version 0xc but this version of numpy is 0x9: file /usr/local/src/swift-build/swift/stdlib/public/core/ErrorType.swift, line 185
        
        // conda install pytorch torchvision -c pytorch
    }
    
}
