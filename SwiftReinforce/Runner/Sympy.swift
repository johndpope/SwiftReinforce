import Foundation
import Python


class SymPy{
    
    typealias PO = PythonObject
    static var math:PythonObject!
    static var np:PythonObject!
    static var sympy:PythonObject!
    static var lambdify:PythonObject!
    static var latex:PythonObject!
    static var sys:PythonObject!
    
    // Schema > Run > Pre-actions - source activate gymai
    static func importSysPath(){
        sys = Python.import("sys")
        let  path = "/Users/\(NSUserName())/miniconda2/envs/gymai/lib/python2.7/site-packages/"
        sys.path.append(path)
        np = Python.import("numpy")
        math = Python.import("math")
        sympy = Python.import("sympy")
        latex = Python.import("sympy.parsing.latex")
        lambdify = Python.import("sympy.utilities.lambdify")
        
    }
    //  https://github.com/fsamija/ethicon/blob/479b7c916d0fc97d05ff94a1694fbc13a7f1a9c3/venvs/edxapp/lib/python2.7/site-packages/sympy/utilities/lambdify.py#L121
    // the lambdify function breaks out of the box - https://github.com/tensorflow/swift/issues/72
    // use lambdastr to get around this - TODO - work out how to eval it.
    
    //Returns a string that can be evaluated to a lambda function.
    static func testLambdifyStr(){
        let a = sympy.DeferredVector("a")
        let s = sympy.DeferredVector("x")
        let t = sympy.Symbol("t")
        
        let dist2 = sympy.Pow(a[0]+s[0]*t,2) + sympy.Pow(a[1]+s[1]*t,2) + sympy.Pow(a[2]+s[2]*t,2)
        let ddist2_dt = sympy.diff(dist2,t)
        let funcArray = sympy.solvers.solve(ddist2_dt, t)
        print("func:",funcArray)
        
        let strTest = lambdify.lambdastr([a,s],funcArray[0])
        print("λ str:",strTest)//lambdastr: lambda a,x: (-(a[0]*x[0] + a[1]*x[1] + a[2]*x[2])/(x[0]**2 + x[1]**2 + x[2]**2))

        let λ = Python.eval(strTest,["builtins":"None"])
        print("λ fn:",λ)

  
//        let xArray = np.array(1)
//        let aArray = np.array(1,1)
//
//        let e0 = Python.map(λ,xArray,aArray)
        
//        print("λ(1,2):",λ(xv,av)
    }
    
//    a = eval("lambda x: print('hello {0}'.format(x))")
//    a("world") # prints "hello world"
    static func helloWorld(){
        return
        let x = sympy.Symbol("x")
        let fn = sympy.Function(Python.print(Python.str("hello {$0}").format(x))) //doesn't work
        let λstr = lambdify.lambdastr(x,fn)
        let λ = Python.eval(λstr,["builtins":"None"])
        λ("world")
    }
    
    static func simpleLambdify(){
        //>>> f = lambdify((x,y,z), [z,y,x])
          //  >>> f(1,2,3)
        
          let x = sympy.Symbol("x")
          let y = sympy.Symbol("y")
          let z = sympy.Symbol("z")
          let fn =  sympy.Function("f")
        
//        class my_func:PythonObject{
//            func eval(){
//                print("ok")
//            }
//
//        }
        
        //        class Person:
        //        def __init__(self, name, age):
        //        self.name = name
        //        self.age = age
        //
        //        def intro(self):
        //        return 'Name: ' + self.name + ', Age: ' + str(self.age)
        //

        
        /* TODO - hook up this function
 class my_func(Function):
 ...
 ...     @classmethod
 ...     def eval(cls, x):
 ...         if x.is_Number:
 ...             if x is S.Zero:
 ...                 return S.One
 ...             elif x is S.Infinity:
 ...                 return S.Zero
 ...
 ...     def _eval_is_real(self):
 ...         return self.args[0].is_real
 */
//         let strTest = lambdify.lambdastr([x,y,z],my_func)
        // eval it
        // exec
        
        
    }
    
    static func testTupleDeclaration(){
        // declare sympy vars by tuple or individually
        let tuple = sympy.symbols("a,b,c,x",real:true)
        print("a:",tuple[0])
        
        //        let a = sympy.Symbol("a")
        //        let b = sympy.Symbol("b")
        //        let c = sympy.Symbol("c")
//        let x = sympy.Symbol("x")
    }
    
    // Solve equation passing variable values
    static func solveEquation(){
        let exp = sympy.S("(a+b)*40-(c-a)/0.5")
        print("exp:",exp)
        let test = exp.evalf(subs:["a":6, "b":5, "c":2])
        print("test:",test)
    }
    
    // import latex code - parse it + symbolicate it to allow evaluation of function.
    static func testLatex(){
        
        // latex 1st sample from https://github.com/kostub/iosMath
        let str = "\\frac{-b  \\sqrt{b^2-4ac}}{2a}"
        let expr = latex.parse_latex(str)
        sympy.init_printing(pretty_print:true,use_latex:true)
        
        print("expr:",expr)
        let test = expr.evalf(subs:["a":1, "b":1, "c":1]) //,"pm":1 -> plus / minus https://github.com/sympy/sympy/issues/5305
        print("test:",test)
    }
    
    static func testBackProp(){
        print("---------------------------")
        // back propagation with sympy < 125 lines of code
       //  https://github.com/Sheyne/Neural/blob/1b0563a65480448a48b395f74a70a7d949112f42/sympy_test.py#L104
        let y = sympy.Symbol("y")
        let t = sympy.Symbol("t")
        let sigmoid = 1/(1+sympy.exp(-y))
        let cross_entropy = y * sympy.ln(t)+(1 - y) * sympy.ln(1 - t)
        let cost =  sympy.Pow((y - t),2) / 2
        let args = sympy.Array([y, t])

        let costFunc = lambdify.lambdastr(args, cost)
        print("costFunc:",costFunc)

        let costP = sympy.diff(cost, y)
        print("costP:",costP)
        
         let costPf = lambdify.lambdastr([y, t],costP)
//        let costPf = sympy.lambdify([y, t], costP) // this blows up  https://github.com/tensorflow/swift/issues/72
        print("costPF:",costP)
        
    }
    
    
    //see lambdify python class
    // https://github.com/fsamija/ethicon/blob/479b7c916d0fc97d05ff94a1694fbc13a7f1a9c3/venvs/edxapp-sandbox/lib/python2.7/site-packages/sympy/utilities/lambdify.py#L171
    static func lambdaSinTest(){
        let abc = Python.import("sympy.abc")
//        let x = abc.x()
        let y = sympy.abc.y()
        let z = sympy.abc.z()
        let x = sympy.Symbol("x")
        print("x:",x)

        /*
         Use own dictionaries:
         >> def my_cool_function(x): ...
         >> dic = {"sin" : my_cool_function}
         >> f = lambdify(x, sin(x), dic)
         Now f would look like:
         >> lambda x: my_cool_function(x)
         */
        // can we pass in swift functions??
        func my_cool_function(){

        }
        let lambdaStr = lambdify.lambdastr(x,x+1)
        let function = sympy.Function("f")
        let fn = Python.import("sympy.utilities.lambdify").implemented_function(function,lambdaStr)
        print("fn:",fn)


//        >>> from sympy.abc import x, y, z
//        let f = sympy.lambdify(x,  1 )
//        let  d0 = ["sin" : my_cool_function]
//        let f = sympy.lambdify(x, math.sin(x), d0)
//        let f = sympy.lambdify(x,  sympy.Pow(x,2) , ["math", "mpmath", "sympy"])
        
    }
    // https://github.com/Sheyne/Neural/blob/1b0563a65480448a48b395f74a70a7d949112f42/sympy_test.py
    static func run(){
        importSysPath()
        
        helloWorld()

        solveEquation()
        testLambdifyStr()
        lambdaSinTest()
        testBackProp()

    }
}
