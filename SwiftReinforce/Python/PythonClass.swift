import Foundation
import Python





class PythonClass{
    typealias PO = PythonObject
    var math:PythonObject!
    var np:PythonObject!
    var numpy:PythonObject!
    
    var sympy:PythonObject!
    var lambdify:PythonObject!
    var latex:PythonObject!
    var latexTools:PythonObject!
    
    var sys:PythonObject!
    var random:PythonObject!
    var keras:PythonObject!
    //custom layers
    var rotationMatrix:PythonObject!
    var layers:PythonObject!
    
    
    // test_lambda.py
    var testLambda:PythonObject!
    
    
    static var runOnce = false
    // Schema > Run > Pre-actions - source activate gymai

    
    // Using miniconda2 / or 3 - change here!!!!!
    func importSysPath(){
        

        if !PythonClass.runOnce{
            // IMPORTANT
            //  - locate site-packages before importing frameworks
            // use 2 or 3 here
            PythonClass.runOnce = true
            sys = Python.import("sys")
            print("INFO - python environment:",environmentName)
            let  path = "/Users/\(NSUserName())/miniconda2/envs/\(environmentName)/lib/python2.7/site-packages/"
            sys.path.append(path)
            let  path3 = "/Users/\(NSUserName())/miniconda3/envs/\(environmentName)/lib/python2.7/site-packages/"
            sys.path.append(path3)
            
            print("INFO: adding to sys path \n",path)
            print("INFO: adding to sys path \n ",path3)
            
            np = Python.import("numpy")
            numpy = Python.import("numpy")
            math = Python.import("math")
            sympy = Python.import("sympy")
            latex = Python.import("sympy.parsing.latex")
            latexTools = Python.import("IPython.lib.latextools")
            lambdify = Python.import("sympy.utilities.lambdify")
            random = Python.import("random")
            

        }

        
    }
    
}


