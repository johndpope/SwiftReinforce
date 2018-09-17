//
//  Array+NumPy.swift
//  SwiftReinforce
//
//  Created by Sascha Schramm on 09.07.18.
//  Copyright © 2018 Sascha Schramm. All rights reserved.
//

import Python
import Foundation

extension Array where Element == UInt8 {
    
    public init?(numpyArray: PythonObject) {
        /*
        guard let np = try? Python.attemptImport("numpy") else {
            return nil
        }
    
        guard Python.isinstance(numpyArray, np.ndarray) == 1 else {
            return nil
        }
        
        let numpyArray = numpyArray.astype(np.uint8)*/
        let numpyArraySize = Int(numpyArray.size)!
        let numpyArrayPointerAddress = UInt(numpyArray.__array_interface__["data"].tuple2.0)!
        let pointer = UnsafePointer<Element>(bitPattern: numpyArrayPointerAddress)!
        let bufferPointer = UnsafeBufferPointer(start: pointer, count: numpyArraySize)
        self.init(bufferPointer)
    }
}
/*
 def prepro(I):
 """ prepro 210x160x3 uint8 frame into 6400 (80x80) 1D float vector """
 I = I[35:195]  # crop
 I = I[::2, ::2, 0]  # downsample by factor of 2
 I[I == 144] = 0  # erase background (background type 1)
 I[I == 109] = 0  # erase background (background type 2)
 I[I != 0] = 1  # everything else (paddles, ball) just set to 1
 return I.astype(np.float).ravel()
 */

// https://github.com/koher/EasyImagy/issues/35

//typealias Matches = (Array<Element>,[Int],[Int]) // all values / matches / non matches

public extension Array where Element: Equatable {
    
    // is flexible and not dependent on equality operand but requires braces within array {}
    // eg.  I[{I % 144}] -> return tuple
    internal subscript(_ condition: (Element) throws -> Bool)   ->   (Array<Element>,[Int],[Int]){
        var matches: [Int] = []
        var nonmatches: [Int] = []
        for (index,element) in self.enumerated() {
            do{
                try condition(element) ? matches.append(index) : nonmatches.append(index)
            }
            catch{
                return (self,matches,nonmatches)
            }
        }
        return (self,matches,nonmatches)
    }
    
    // currently this needs to be an array
    //   I[I == 1.0] = [2.0]
    //   TODO - allow I[I == 1.0] = 2
    // this reflects the array tuple subscript of all matches where I == 1.0
   internal  subscript (_ matches: (Array<Element>,[Int],[Int])) -> Array<Element> {
        get{
            return self
        }
        set{
            
             for (_,element) in matches.1.enumerated() {
                self[element] =  newValue[0]
            }
        }
    }
    
    
}


//   Intention  was to detect pixels of certain value within large array
///  Return all elements plus 2 arrays of indices matched and non matched by predicate.
//    var I = [0, 1, 2, 3, 4, 5,26,1,1]
//    let tuple =   I == 1
//    tuple[0] = [0, 1, 2, 3, 4, 5,26,1,1]
//    tuple[1] =  [0,6,7]
//    tuple[1] = [1,2,3,4,5]
func == <Element: Equatable>(lhs: Array<Element>, rhs: Element) ->  (Array<Element>,[Int],[Int])
{
    var matches: [Int] = []
    let range = lhs.indices
    let min = range.min()!
    let max = range.max()!
    var nonmatches: [Int] = Array(min...max ) // this is a duplicate of self.indices.

    
    for (index,element) in lhs.enumerated() {
     
            if element == rhs{
                matches.append(index)
            }
    }
    for (index,_) in matches.enumerated() {
        nonmatches.remove(at: index)
    }
    return (lhs,matches,nonmatches)
}

func == <Element: Equatable>(lhs:   (Array<Element>,[Int],[Int]),  rhs: inout Any){
    
    print("matched")
//    return lhs
}
