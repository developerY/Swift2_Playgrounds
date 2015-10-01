//: ## Classes and Initializers
//:
//: In object-oriented programming, the behavior of a program is based largely on interactions between objects. An _object_ is an instance of a _class_, which can be thought of as a blueprint for that object. Classes store additional information about themselves in the form of _properties_, and define their behavior using methods.
//:
//: Use `class` followed by the class’s name to define a class. A property declaration in a class is written the same way as a constant or variable declaration, except that it’s in the context of a class. Likewise, method and function declarations are written the same way. This example declares a `Shape` class with a `numberOfSides` property and a `simpleDescription()` method.
//:
class Shape {
    var numberOfSides = 0
    func simpleDescription() -> String {
        return "A shape with \(numberOfSides) sides."
    }
}

//: Create an instance of a class—an object—by putting parentheses after the class name. Use dot syntax to access the properties and methods of the instance. Here, `shape` is an object that’s an instance of the `Shape` class.
//:
var shape = Shape()
shape.numberOfSides = 7
var shapeDescription = shape.simpleDescription()

//: This `Shape` class is missing something important: an initializer. An _initializer_ is a method that prepares an instance of a class for use, which involves setting an initial value for each property and performing any other setup. Use `init` to create one. This example defines a new class, `NamedShape`, that has an initializer which takes in a name.
//:
class NamedShape {
    var numberOfSides = 0
    var name: String

    init(name: String) {
       self.name = name
    }

    func simpleDescription() -> String {
       return "A shape with \(numberOfSides) sides."
    }
}

//: Notice how `self` is used to distinguish the `name` property from the `name` argument to the initializer. Every property needs a value assigned—either in its declaration (as with `numberOfSides`) or in the initializer (as with `name`).
//:
//: You don’t call an initializer by writing `init`; you call it by putting parentheses with the appropriate arguments after the class name. When you call an initializer, you include all arguments names along with their values. 
//:
let namedShape = NamedShape(name: "my named shape")

//: Classes _inherit_ their behavior from their parent class. A class that inherits behavior from another class is called a _subclass_ of that class, and the parent class is called a _superclass_. Subclasses include their superclass name after their class name, separated by a colon. A class can inherit from only one superclass, although that class can inherit from another superclass, and so on, resulting in a _class hierarchy_.
//:
//: Methods on a subclass that _override_ the superclass’s implementation are marked with `override`—overriding a method by accident, without `override`, is detected by the compiler as an error. The compiler also detects methods with `override` that don’t actually override any method in the superclass.
//:
//: This example defines the `Square` class, a subclass of `NamedShape`.
//:
class Square: NamedShape {
    var sideLength: Double

    init(sideLength: Double, name: String) {
        self.sideLength = sideLength
        super.init(name: name)
        numberOfSides = 4
    }

    func area() ->  Double {
        return sideLength * sideLength
    }

    override func simpleDescription() -> String {
        return "A square with sides of length \(sideLength)."
    }
}
let testSquare = Square(sideLength: 5.2, name: "my test square")
testSquare.area()
testSquare.simpleDescription()

//: Notice that the initializer for the `Square` class has three different steps:
//:
//: 1. Setting the value of properties that the subclass, `Square`, declares.
//:
//: 1. Calling the initializer of the superclass, `NamedShape`.
//:
//: 1. Changing the value of properties defined by the superclass, `NamedShape`. Any additional setup work that uses methods, getters, or setters can also be done at this point.
//:
//: Sometimes, initialization of an object needs to fail, such as when the values supplied as the arguments are outside of a certain range, or when data that’s expected to be there is missing. Initializers that may fail to successfully initialize an object are called failable initializers. A _failable initializer_ can return `nil` after initialization. Use `init?` to declare a failable initializer.
//:
class Circle: NamedShape {
    var radius: Double

    init?(radius: Double, name: String) {
        self.radius = radius
        super.init(name: name)
        numberOfSides = 1
        if radius <= 0 {
            return nil
        }
    }

    override func simpleDescription() -> String {
        return "A circle with a radius of \(radius)."
    }
}
let successfulCircle = Circle(radius: 4.2, name: "successful circle")
let failedCircle = Circle(radius: -7, name: "failed circle")

//: Initializers can have quite a few keywords associated with them. A _designated initializer_ indicates that it’s one of the primary initializers for a class; any initializer within a class must ultimately call through to a designated initializer. A _convenience initializer_ is a secondary initializer, which adds additional behavior or customization, but must eventually call through to a designated initializer. Designated and convenience initializers are indicated with the `designated` and `convenience` keywords, respectively.
//:
//: A `required` keyword next to an initializer indicates that every subclass of the class that has that initializer must implement its own version of the initializer (if it implements any initializer).
//:
//: _Type casting_ is a way to check the type of an instance, and to treat that instance as if it’s a different superclass or subclass from somewhere else in its own class hierarchy.
//:
//: A constant or variable of a certain class type may actually refer to an instance of a subclass behind the scenes. Where you believe this is the case, you can try to _downcast_ to the subclass type using a type cast operator.
//:
//: Because downcasting can fail, the type cast operator comes in two different forms. The optional form, `as?`, returns an optional value of the type you are trying to downcast to. The forced form, `as!`, attempts the downcast and force-unwraps the result as a single compound action.
//:
//: Use the _optional type cast operator_ (`as?`) when you’re not sure if the downcast will succeed. This form of the operator will always return an optional value, and the value will be `nil` if the downcast was not possible. This lets you check for a successful downcast.
//:
//: Use the _forced type cast operator_ (`as!`) only when you’re sure that the downcast will always succeed. This form of the operator will trigger a runtime error if you try to downcast to an incorrect class type.
//:
//: This example shows the use of the optional type cast operator (`as?`) to check whether a shape in an array of shapes is a circle or a square. You increment the count of the `squares` and `triangles` variables by one each time the corresponding shape is found, printing the values at the end.
//:
class Triangle: NamedShape {
    init(sideLength: Double, name: String) {
        super.init(name: name)
        numberOfSides = 3
    }
}

let shapesArray = [Triangle(sideLength: 1.5, name: "triangle1"), Triangle(sideLength: 4.2, name: "triangle2"), Square(sideLength: 3.2, name: "square1"), Square(sideLength: 2.7, name: "square2")]
var squares = 0
var triangles = 0
for shape in shapesArray {
   if let square = shape as? Square {
      squares++
   } else if let triangle = shape as? Triangle {
      triangles++
   }
}
print("\(squares) squares and \(triangles) triangles.")

//: > **Experiment**:
//: > Try replacing `as?` with `as!`. What error do you get?
//:
//: [Previous](@previous) | [Next](@next)
