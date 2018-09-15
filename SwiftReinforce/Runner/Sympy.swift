import Foundation
import Python



class SymPy{
    
    typealias PO = PythonObject
    // Schema > Run > Pre-actions - source activate gymai
    static func importSysPath(){
        let sys = Python.import("sys")
        let  path = "/Users/\(NSUserName())/miniconda2/envs/gymai/lib/python2.7/site-packages/"
        sys.path.append(path)
        
    }
    
    // https://github.com/Sheyne/Neural/blob/1b0563a65480448a48b395f74a70a7d949112f42/sympy_test.py
    static func run(){
        importSysPath()
        
        let sympy = Python.import("sympy")
        let np = Python.import("numpy")
        let mpmath = Python.import("mpmath")
        
        let t = sympy.Symbol("t")
        let y = sympy.Symbol("y")
        
        let sigmoid = 1/(1+sympy.exp(-y))
        let cross_entropy = y * sympy.ln(t)+(1 - y) * sympy.ln(1 - t)
        let cost =  sympy.Pow((y - t),2) / 2
        let arr = [y, t]
        let costFunc = sympy.lambdify(arr, cost, np)
        let costP = sympy.diff(cost, y)
        let costPf = sympy.lambdify([y, t], costP, np)
        print("costPF:",costP)

    }
}
