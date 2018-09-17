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
    var sys:PythonObject!
    static var runOnce = false
    // Schema > Run > Pre-actions - source activate gymai
    func importClasses(){
        np = Python.import("numpy")
        numpy = Python.import("numpy")
        math = Python.import("math")
        sympy = Python.import("sympy")
        latex = Python.import("sympy.parsing.latex")
        lambdify = Python.import("sympy.utilities.lambdify")
    }
    
    func importSysPath(){
        
        if !PythonClass.runOnce{
            PythonClass.runOnce = true
            sys = Python.import("sys")
            let  path = "/Users/\(NSUserName())/miniconda2/envs/gymai/lib/python2.7/site-packages/"
            sys.path.append(path)
        }
        importClasses()

        
    }
    
}