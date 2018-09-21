import Foundation
import Python




class SkLearn:PythonClass{
    
 
    func run(){
        importSysPath()
        
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

