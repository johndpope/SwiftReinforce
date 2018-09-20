from sympy import Function, S, oo, I, sin

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

