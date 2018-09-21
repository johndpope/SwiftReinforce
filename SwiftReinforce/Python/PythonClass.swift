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

    func importSysPath(){
        

        if !PythonClass.runOnce{

            PythonClass.runOnce = true
          
            sys = Python.import("sys")
            
            importConda()
            importThisProjectFolder()
            
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


