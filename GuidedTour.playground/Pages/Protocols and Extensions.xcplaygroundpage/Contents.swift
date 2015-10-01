//: ## Protocols
//:
//: A _protocol_ defines a blueprint of methods, properties, and other requirements that suit a particular task or piece of functionality. The protocol doesn’t actually provide an implementation for any of these requirements—it only describes what an implementation will look like. The protocol can then be _adopted_ by a class, structure, or enumeration to provide an actual implementation of those requirements. Any type that satisfies the requirements of a protocol is said to _conform_ to that protocol.
//:
//: Use `protocol` to declare a protocol.
//:
protocol ExampleProtocol {
     var simpleDescription: String { get }
     mutating func adjust()
}

//: > **Note**:
//: > The `{ get }` following the `simpleDescription` property indicates that it is _read-only_, meaning that the value of the property can be viewed, but never changed.
//:
//: Protocols can require that conforming types have specific instance properties, instance methods, type methods, operators, and subscripts. Protocols can require specific instance methods and type methods to be implemented by conforming types. These methods are written as part of the protocol’s definition in exactly the same way as for normal instance and type methods, but without curly braces or a method body.
//:
//: Classes, structures, and enumerations adopt a protocol by listing its name after their name, separated by a colon. A type can adopt any number of protocols, which appear in a comma-separated list. If a class has a superclass, the superclass’s name must appear first in the list, followed by protocols. You conform to the protocol by implementing all of its requirements.
//:
//: Here, `SimpleClass` adopts the `ExampleProtocol` protocol, and conforms to the protocol by implementing the `simpleDescription` property and `adjust()` method.
//:

class SimpleClass: ExampleProtocol {
     var simpleDescription: String = "A very simple class."
     var anotherProperty: Int = 69105
     func adjust() {
          simpleDescription += "  Now 100% adjusted."
     }
}
var a = SimpleClass()
a.adjust()
let aDescription = a.simpleDescription

struct SimpleStructure: ExampleProtocol {
    var simpleDescription: String = "A simple structure"
    mutating func adjust() {
        simpleDescription += " (adjusted)"
    }
}
var b = SimpleStructure()
b.adjust()
let bDescription = b.simpleDescription

//: Protocols are first-class types, which means they can be treated like other named types. For example, you can create an `ExampleProtocol` array and call `adjust()` on each of the instances in it (because any instance in that array would be guaranteed to implement `adjust()`, one of the protocol’s requirements).
//:
class SimpleClass2: ExampleProtocol {
    var simpleDescription: String = "Another very simple class."
    func adjust() {
        simpleDescription += "  Adjusted."
    }
}

var protocolArray: [ExampleProtocol] = [SimpleClass(), SimpleStructure(), SimpleClass2()]
for var structInstance in protocolArray {
    structInstance.adjust()
}
protocolArray

//: > **Experiment**:
//: > Write an enumeration that conforms to this protocol.
//:
//: Notice the use of the `mutating` keyword in the declaration of `SimpleStructure` to mark a method that modifies the structure. The declaration of `SimpleClass` doesn’t need any of its methods marked as mutating because methods on a class can always modify the class.
//:
//: Use `extension` to add functionality to an existing type, such as new methods and computed properties. You can use an extension to add protocol conformance to a type that is declared elsewhere, or even to a type that you imported from a library or framework.
//:
extension Int: ExampleProtocol {
    var simpleDescription: String {
        return "The number \(self)"
    }
    mutating func adjust() {
        self += 42
    }
 }
print(7.simpleDescription)

//: > **Experiment**:
//: > Write an extension for the `Double` type that adds an `absoluteValue` property.
//:
//: You can use a protocol name just like any other named type—for example, to create a collection of objects that have different types but that all conform to a single protocol. When you work with values whose type is a protocol type, methods outside the protocol definition are not available.
//:
let protocolValue: ExampleProtocol = a
print(protocolValue.simpleDescription)
// print(protocolValue.anotherProperty)  // Uncomment to see the error

//: Even though the variable `protocolValue` has a runtime type of `SimpleClass`, the compiler treats it as the given type of `ExampleProtocol`. This means that you can’t accidentally access methods or properties that the class implements in addition to its protocol conformance.

//: ### Essentially protocols are very similar to Java interfaces except for:
/*:
* Swift protocols can also specify properties that must be implemented (i.e. fields)
* Swift protocols need to deal with value/reference through the use of the mutating keyword (because protocols can be implemented by structs and classes)
* you can combine protocols at any point with the protocol<> keyword. For example, declaring a function parameter that must adhere to protocol A and B as: func foo ( var1 : protocol<A, B> ){}
*/


//: *Examine the difference between Protocols and Inheritance* ::
//: https://www.weheartswift.com/swift-classes-part-2/



//: [Previous](@previous) | [Next](@next)
