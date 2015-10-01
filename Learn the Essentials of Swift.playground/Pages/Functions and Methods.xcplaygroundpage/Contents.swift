//: ## Functions and Methods
//:
//: A _function_ is a reusable, named piece of code that can be referred to from many places in a program.
//:
//: Use `func` to declare a function. A function declaration can include zero or more _parameters_, written as `name: Type`, which are additional pieces of information that must be passed into the function when it’s called. Optionally, a function can have a return type, written after the `->`, which indicates what the function returns as its result. A function’s implementation goes inside of a pair of curly braces (`{}`).
//:
func greet(name: String, day: String) -> String {
    return "Hello \(name), today is \(day)."
}

//: Call a function by following its name with a list of _arguments_ (the values you pass in to satisfy a function’s parameters) in parentheses. When you call a function, you pass in the first argument value without writing its name, and every subsequent value with its name.
//:
greet("Anna", day: "Tuesday")
greet("Bob", day: "Friday")
greet("Charlie", day: "a nice day")

//: Functions that are defined within a specific type are called _methods_. Methods are explicitly tied to the type they’re defined in, and can only be called on that type (or one of its subclasses, as you’ll learn about soon). In the earlier `switch` statement example, you saw a method that’s defined on the `String` type called `hasSuffix()`, shown again here:
//:
let exampleString = "hello"
if exampleString.hasSuffix("lo") {
    print("ends in lo")
}

//: As you see, you call a method using the dot syntax. When you call a method, you pass in the first argument value without writing its name, and every subsequent value with its name. For example, this method on `Array` takes two parameters, and you only pass in the name for the second one:
//:
var array = ["apple", "banana", "dragonfruit"]
array.insert("cherry", atIndex: 2)
array

//: [Previous](@previous) | [Next](@next)
