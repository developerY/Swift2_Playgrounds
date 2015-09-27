//: ## Protocols
//:
//: A _protocol_ defines a blueprint of methods, properties, and other requirements that suit a particular task or piece of functionality. The protocol doesn’t actually provide an implementation for any of these requirements—it only describes what an implementation will look like. The protocol can then be _adopted_ by a class, structure, or enumeration to provide an actual implementation of those requirements. Any type that satisfies the requirements of a protocol is said to _conform_ to that protocol.
//:
//: Use `protocol` to declare a protocol.
//:
protocol ExampleProtocol {
     var simpleDescription: String { get }
     func adjust()
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

//: Protocols are first-class types, which means they can be treated like other named types. For example, you can create an `ExampleProtocol` array and call `adjust()` on each of the instances in it (because any instance in that array would be guaranteed to implement `adjust()`, one of the protocol’s requirements).
//:
class SimpleClass2: ExampleProtocol {
     var simpleDescription: String = "Another very simple class."
     func adjust() {
          simpleDescription += "  Adjusted."
     }
}

var protocolArray: [ExampleProtocol] = [SimpleClass(), SimpleClass(), SimpleClass2()]
for instance in protocolArray {
   instance.adjust()
}
protocolArray

//: [Previous](@previous) | [Next](@next)
