//
//  Conda.swift
//  SwiftReinforce
//
//  Created by Pope, John on 9/21/18.
//  Copyright © 2018 Sascha Schramm. All rights reserved.
//

import Foundation

// IMPORTANT - if you're using a different environment name
// Schema > Run > Pre-actions - source activate gymai
let environmentName = "gymai"

extension PythonClass{
    
    func importConda(){
        
        print("INFO: 🐍 conda environment:",environmentName)
        let  path = "/Users/\(NSUserName())/miniconda2/envs/\(environmentName)/lib/python2.7/site-packages/"
        sys.path.append(path)
        let  path3 = "/Users/\(NSUserName())/miniconda3/envs/\(environmentName)/lib/python2.7/site-packages/"
        sys.path.append(path3)
        
        print("INFO: sys path \n",path)
        print("INFO: sys path \n ",path3)
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
}
