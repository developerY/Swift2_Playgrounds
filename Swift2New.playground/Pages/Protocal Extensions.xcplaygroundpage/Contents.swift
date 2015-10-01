//: [Previous](@previous)

import Foundation

var str = "Hello, playground"


//: extensions
extension String {
    var thatIsWhatSheSaid : String {
        return self + " : Ans : that is what she said"
    }
    var inBed : String {
        return self + " in bed"
    }
}

let svtxt : String = "Silicon Valley is cool"
svtxt.thatIsWhatSheSaid
svtxt.inBed

//                      //
// Protocol Extensions  //
//                      //

protocol Awesome {
    func awesomenessPercentage() -> Float
}

class Dog: Awesome {
    var age: Int!
    func awesomenessPercentage() -> Float {
        return 0.85
    }
}

class Cat: Awesome {
    var age: Int!
    func awesomenessPercentage() -> Float {
        return 0.45
    }
}

let dog = Dog()
dog.awesomenessPercentage()

let cat = Cat()
cat.awesomenessPercentage()

/*
extension Cat {
    var decades: Int {
        get {
            return self.age / 10
        }
    }
}
*/


extension Awesome {
    var awesomenessIndex: Int {
        get {
            return Int(awesomenessPercentage() * 100)
        }
    }
}

dog.awesomenessIndex
cat.awesomenessIndex

//: [Next](@next)
