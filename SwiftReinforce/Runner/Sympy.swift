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
        
        let sp = Python.import("sympy")
        let latex = Python.import("sympy.parsing.latex")
        
        // declare sympy vars by tuple or individually
        let tuple = sp.symbols("a,b,c,x",real:true)
        print("a:",tuple[0])
        
//        let a = sp.Symbol("a")
//        let b = sp.Symbol("b")
//        let c = sp.Symbol("c")
//        let x = sp.Symbol("x")

        
        // Solve equation passing variable values
        let exp = sp.S("(a+b)*40-(c-a)/0.5")
         print("exp:",exp)
        var test = exp.evalf(subs:["a":6, "b":5, "c":2])
        print("test:",test)
        
        // latex 1st sample from https://github.com/kostub/iosMath
        let str = "\\frac{-b  \\sqrt{b^2-4ac}}{2a}"
        let expr = latex.parse_latex(str)
        sp.init_printing(pretty_print:true,use_latex:true)

        print("expr:",expr)
        test = expr.evalf(subs:["a":1, "b":1, "c":1]) //,"pm":1 -> plus / minus https://github.com/sympy/sympy/issues/5305
        print("test:",test)

        
        
        // back propagation with sympy < 125 lines of code
        // https://github.com/Sheyne/Neural/blob/1b0563a65480448a48b395f74a70a7d949112f42/sympy_test.py#L104
        let y = sp.Symbol("y")
        let t = sp.Symbol("t")
        let sigmoid = 1/(1+sp.exp(-y))
        let cross_entropy = y * sp.ln(t)+(1 - y) * sp.ln(1 - t)
        let cost =  sp.Pow((y - t),sp.Integer(2)) / sp.Integer(2)
        let args = sp.Array([y, t])
        let costFunc = sp.lambdify(args, cost,modules:"numpy") // this blows up - : Python exception: 'NoneType' object has no attribute 'f_locals'
        //https://groups.google.com/forum/#!topic/sympy/vQACccLGxsk
        let costP = sp.diff(cost, y)
//        let costPf = sp.lambdify([y, t], costP)
//        print("costPF:",costP)

    }
}
