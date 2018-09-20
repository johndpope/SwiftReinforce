from sympy import Function, S, oo, I, sin
from sympy.abc import x
from sympy.utilities.lambdify import lambdify, implemented_function

class my_func(Function):
    @classmethod
    def eval(cls, x):
        if x.is_Number:
            if x is S.Zero:
                return S.One
            elif x is S.Infinity:
                return S.Zero
                
    def _eval_is_real(self):
        return self.args[0].is_real

    def my_cool_function(x):
        return 'sin(%s) is cool' % x

            
#https://docs.sympy.org/latest/modules/utilities/lambdify.html
#>>> from sympy.abc import x
#>>> from sympy.utilities.lambdify import lambdify, implemented_function
#>>> from sympy import Function
#>>> f = implemented_function('f', lambda x: x+1)
#>>> lam_f = lambdify(x, f(x))
#>>> lam_f(4) -> 5

    @staticmethod
    def test(z):
        f = implemented_function('f', lambda x: x+1)
        lam_f = lambdify(x, f(x))
        z = lam_f(z)
        return 'z(%s) '  % z


