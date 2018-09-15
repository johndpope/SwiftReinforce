import Foundation
import Python


class PythonImport{
    typealias PO = PythonObject
    // Schema > Run > Pre-actions - source activate gymai
    //Fatal error: 'try!' expression unexpectedly raised an error: Python exception: No module named theano:
    static func importSys(){
        let sys = Python.import("sys")
        let  path = "/Users/\(NSUserName())/miniconda2/envs/gymai/lib/python2.7/site-packages/"
        sys.path.append(path)
        
    }
}

class SkLearn:PythonImport{
    
 
    static func run(){
        SkLearn.importSys()
        
        let dataset = Python.import("sklearn.datasets").load_digits()
        let classifier = Python.import("sklearn.svm").LinearSVC()
        let (xTrain, xTest, yTrain, yTest) = Python.import("sklearn.model_selection").train_test_split(dataset["data"], dataset["target"]).tuple4

        classifier.fit(xTrain, yTrain)
        print("train: \(classifier.score(xTrain, yTrain))")
        print("test:  \(classifier.score(xTest, yTest))")
        
        
        // Feature extraction
        // http://scikit-learn.org/stable/modules/feature_extraction.html
        let v = Python.import("sklearn.feature_extraction").DictVectorizer(sparse:false)
        let d = [["foo": 1, "bar": 2],[ "foo": 3, "baz": 1]]
        let x = v.fit_transform(d)
        print("X:",x)
        let y = v.inverse_transform(x)
        print("Y:",y)
        let w = v.transform(["foo": 4, "unseen_feature": 3])
        print("W",w)
        

    }
}


//FAILS - missing pickle
class Theano:PythonImport{
    
    
    static func run(){
        
        SkLearn.importSys()
        let np = Python.import("numpy")
        //let nn = Python.import("pytorch").nn()
        let pickle = Python.import("pickle")
        let theano = Python.import("theano") // use miniconda2 + conda install theano
        let T = Python.import("theano.tensor") //import theano.tensor as T
        
        
        // Returns a new Theano scalar.
        func makeScalar()->PO{
            return T.scalar()
        }
        
        //Returns the logarithm of a Theano scalar x.
        func log(_ x:PO)->PO{
            return T.log(x)
        }
        
        //  Adds two theano scalars together and returns the result.
        func add(_ x:PO,_ y:PO)->PO{
            return x + y
        }
        
        var a = makeScalar()
        var b = makeScalar()
        let c = log(b)
        let d = add(a, c)
        let array = [a, b]
        let f = theano.function(array, d)
        a = np.cast[a.dtype](1)
        b = np.cast[b.dtype](2)
        let actual = f(a,b)
        let expected = 1 + np.log(2)
    }
}



/*
    >>> from sklearn.feature_extraction import DictVectorizer
>>> v = DictVectorizer(sparse=False)
    >>> D = [{'foo': 1, 'bar': 2}, {'foo': 3, 'baz': 1}]
    >>> X = v.fit_transform(D)
    >>> X
array([[ 2., 0., 1.],
       [ 0., 1., 3.]])
    >>> v.inverse_transform(X) == [{'bar': 2.0, 'foo': 1.0}, {'baz': 1.0, 'foo
        ˓→': 3.0}]
        True
        >>> v.transform({'foo': 4, 'unseen_feature': 3})
        array([[ 0., 0., 4.]])
*/

