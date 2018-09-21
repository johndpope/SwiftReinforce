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
    var cPickle:PythonObject!
    var torch:PythonObject!
    
    
    //custom layers
    var rotationMatrix:PythonObject!
    var layers:PythonObject!

    
    // test_lambda.py
    var testLambda:PythonObject!



    func importSysPath(){
        sys = Python.import("sys")
        print("INFO: macOS sysPath:", sys.path)        
        importPackages()
    }
    
    
    func importPackages(){

            importConda()
            importThisProjectFolder()
            importNumpy()

            math = Python.import("math")
            sympy = Python.import("sympy")
            latex = Python.import("sympy.parsing.latex")
            latexTools = Python.import("IPython.lib.latextools")
            lambdify = Python.import("sympy.utilities.lambdify")
            random = Python.import("random")
            cPickle = Python.import("cPickle")
            
            importPytorch()


        
    }
    
}


