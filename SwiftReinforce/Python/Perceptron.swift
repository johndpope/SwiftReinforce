import Foundation
import Python

//
//        fromfrom  numpynumpy  importimport  arrayarray,,  dotdot,,  randomrandom
//        fromfrom  randomrandom  importimport  choicechoice


class Perceptron:PythonClass{
    
    func  runNet(){
        importSysPath()

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
    }
    
    func test(){
        /*
        let eq = 0 if x < 0 else 1
        let funcArray = sympy.solvers.solve(ddist2_dt, t)
        let activation = lambdify.lambdastr([a,s],funcArray[0]) // lambda x:
        
        training_data = [
        (array([0,0,1]), 0),
        (array([0,1,1]), 1),
        (array([1,0,1]), 1),
        (array([1,1,1]), 1),
        ]
        
        w = random.rand(3)
        eta = 0.2
        n = 100
        
        
        func dotTwo(x, y){
            if len(x) != len(y):
            raise Exception(f'Vectors are of unequal length: {len(x)}, {len(y)}')
            result = 0
            for i in range(len(x)):
            result += x[i] * y[i]
            return result
        }
        
        
        
        for i in range(n){
            x, expected = choice(training_data)
            result = dot_two(w, x)
            error = expected - activation(result)
            w += eta * error * x
        }
        
        for x, _ in training_data{
            result = dot(x, w)
            print("{}: {} -> {}".format(x[:2], result, activation(result)))
        }
*/

        
    }
    
}
