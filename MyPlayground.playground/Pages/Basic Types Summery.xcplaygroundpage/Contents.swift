//: ## Basic Types
//:
//: A _constant_ is a value that stays the same after it’s declared the first time, while a _variable_ is a value that can change. A constant is referred to as immutable, meaning that it can’t be changed, and a variable is mutable. If you know that a value won’t need to be changed in your code, declare it as a constant instead of a variable.
//:
//: Use `let` to make a constant and `var` to make a variable.
//:
var myVariable = 42
myVariable = 50
let myConstant = 42

//: Every constant and variable in Swift has a type, but you don’t always have to write the type explicitly. Providing a value when you create a constant or variable lets the compiler infer its type. In the example above, the compiler infers that `myVariable` is an integer because its initial value is an integer. This is called _type inference_. Once a constant or variable has a type, that type can’t be changed.
//:
//: If the initial value doesn’t provide enough information (or if there is no initial value), specify the type by writing it after the variable, separated by a colon.
//:
let implicitInteger = 70
let implicitDouble = 70.0
let explicitDouble: Double = 70

//: > **Experiment**:
//: > In Xcode, Option-click the name of a constant or variable to see its inferred type. Try doing that with the constants in the code above.
//:
//: Values are never implicitly converted to another type. If you need to convert a value to a different type, explicitly make an instance of the desired type. Here, you convert an `Int` to a `String`.
//:
let label = "The width is "
let width = 94
let widthLabel = label + String(width)

//: > **Experiment**:
//: > Try removing the conversion to `String` from the last line. What error do you get?
//:
//: There’s an even simpler way to include values in strings: Write the value in parentheses, and write a backslash (`\`) before the parentheses. This is known as _string interpolation_.
//:
let apples = 3
let oranges = 5
let appleSummary = "I have \(apples) apples."
let fruitSummary = "I have \(apples + oranges) pieces of fruit."

//: Use optionals to work with values that might be missing. An optional value either contains a value or contains `nil` (no value) to indicate that a value is missing. Write a question mark (`?`) after the type of a value to mark the value as optional.
//:
let optionalInt: Int? = 9

//: To get the underlying type from an optional, you _unwrap_ it. You’ll learn unwrapping optionals later, but the most straightforward way to do it involves the _force unwrap operator_ (`!`). Only use the unwrap operator if you’re sure the underlying value isn’t `nil`.
//:
let actualInt: Int = optionalInt!

//: Optionals are pervasive in Swift, and are very useful for many situations where a value may or may not be present. They’re especially useful for attempted type conversions.
//:
var myString = "7"
var possibleInt = Int(myString)
print(possibleInt)

//: In this code, the value of `possibleInt` is `7`, because `myString` contains the value of an integer. But if you change `myString` to be something that can’t be converted to an integer, `possibleInt` becomes `nil`.
//:
myString = "banana"
possibleInt = Int(myString)
print(possibleInt)

//: 
//:
//: An array is a data type that keeps track of an ordered collection of items. Create arrays using brackets (`[]`), and access their elements by writing the index in brackets. Arrays start at index `0`.
//:
var ratingList = ["Poor", "Fine", "Good", "Excellent"]
ratingList[1] = "OK"
ratingList

//: To create an empty array, use the initializer syntax. You’ll learn more about initializers in a little while.
//:
// Creates an empty array.
let emptyArray = [String]()

//: You’ll notice that the code above has a comment. A _comment_ is a piece of text in a source code file that doesn’t get compiled as part of the program but provides context or useful information about individual pieces of code. A single-line comment appears after two slashes (`//`) and a multiline comment appears between a set of slashes and asterisks (`/*` … `*/`). You’ll see and write both types of comments throughout the source code in the lessons.
//:
//: An _implicitly unwrapped optional_ is an optional that can also be used like a nonoptional value, without the need to unwrap the optional value each time it’s accessed. This is because an implicitly unwrapped optional is assumed to always have a value after that value is initially set, although the value can change. Implicitly unwrapped optional types are indicated with an exclamation mark (`!`) instead of a question mark (`?`).
//:
var implicitlyUnwrappedOptionalInt: Int!

//: You’ll rarely need to create implicitly unwrapped optionals in your own code. More often, you’ll see them used to keep track of outlets between an interface and source code (which you’ll learn about in a later lesson) and in the _APIs_ you’ll see throughout the lessons.
//:
//: [Previous](@previous) | [Next](@next)
