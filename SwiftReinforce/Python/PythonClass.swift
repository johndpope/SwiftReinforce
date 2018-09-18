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
    var random:PythonObject!
    
    //custom layers
    var rotationMatrix:PythonObject!
    var layers:PythonObject!
    
    
    static var runOnce = false
    // Schema > Run > Pre-actions - source activate gymai
    func importClasses(){
        np = Python.import("numpy")
        numpy = Python.import("numpy")
        math = Python.import("math")
        sympy = Python.import("sympy")
        latex = Python.import("sympy.parsing.latex")
        lambdify = Python.import("sympy.utilities.lambdify")
        random = Python.import("random")

        
    }
    
    func importSysPath(){
        
        if !PythonClass.runOnce{
            PythonClass.runOnce = true
            sys = Python.import("sys")
            let  path = "/Users/\(NSUserName())/miniconda2/envs/gymai/lib/python2.7/site-packages/"
            sys.path.append(path)
            
            let  customClassPath = "/Users/jpope/Documents/tensorflowWorkspace/SE2CNN/se2cnn"
            sys.path.append(customClassPath)

            numpy = Python.import("numpy")
            rotationMatrix  = Python.import("rotation_matrix")
           
            
           let  myoutput = rotationMatrix.CoordRotationInv( [1.5,4.3], [5,5], Double.pi/4 )
            print("\n\n\n")
            print("myoutput:",myoutput)
            
//            Python.help(rotationMatrix.CoordRotationInv)
            
        }
        importClasses()

        
    }
    
}


