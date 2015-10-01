//: ## Control Flow
//:
//: Swift has two types of control flow statements. _Conditional statements_, like `if` and `switch`, check whether a condition is true—that is, if its value evaluates to the Boolean `true`—before executing a piece of code. _Loops_, like `for`-`in` and `while`, execute the same piece of code multiple times. 
//:
//: An `if` statement checks whether a certain condition is true, and if it is, the `if` statement evaluates the code inside the statement. You can add an `else` clause to an `if` statement to define more complex behavior. An `else` clause can be used to chain `if` statements together, or it can stand on its own, in which case the `else` clause is executed if none of the chained `if` statements evaluate to `true`.
//:
let number = 23
if number < 10 {
    print("The number is small")
} else if number > 100 {
    print("The number is pretty big")
} else {
    print("The number is between 10 and 100")
}

//: > **Experiment**:
//: > Change `number` to a different integer value to see how that affects which line prints.
//:
//: Statements can be nested to create complex, interesting behavior in a program. Here’s an example of an `if` statement with an `else` clause nested inside a `for`-`in` statement (which iterates through each item in a collection in order, one-by-one).
//:
let individualScores = [75, 43, 103, 87, 12]
var teamScore = 0
for score in individualScores {
    if score > 50 {
        teamScore += 3
    } else {
        teamScore += 1
    }
}
print(teamScore)

//: Use _optional binding_ in an `if` statement to check whether an optional contains a value.
//:
var optionalName: String? = "John Appleseed"
var greeting = "Hello!"
if let name = optionalName {
    greeting = "Hello, \(name)"
}

//: > **Experiment**:
//: > Change `optionalName` to `nil`. What greeting do you get? Add an `else` clause that sets a different greeting if `optionalName` is `nil`.
//:
//: If the optional value is `nil`, the conditional is `false`, and the code in braces is skipped. Otherwise, the optional value is unwrapped and assigned to the constant after `let`, which makes the unwrapped value available inside the block of code.
//:
//: You can use a single `if` statement to bind multiple values. A `where` clause can be added to a case to further scope the conditional statement. In this case, the `if` statement executes only if the binding is successful for all of these values and all conditions are met.
//:
var optionalHello: String? = "Hello"
if let hello = optionalHello where hello.hasPrefix("H"), let name = optionalName {
    greeting = "\(hello), \(name)"
}

//: Switches in Swift are quite powerful. A `switch` statement supports any kind of data and a wide variety of comparison operations—it isn’t limited to integers and tests for equality. In this example, the `switch` statement switches on the value of the `vegetable` string, comparing the value to each of its cases and executing the one that matches.
//:
let vegetable = "red pepper"
switch vegetable {
    case "celery":
        let vegetableComment = "Add some raisins and make ants on a log."
    case "cucumber", "watercress":
        let vegetableComment = "That would make a good tea sandwich."
    case let x where x.hasSuffix("pepper"):
        let vegetableComment = "Is it a spicy \(x)?"
    default:
        let vegetableComment = "Everything tastes good in soup."
}

//: > **Experiment**:
//: > Try removing the default case. What error do you get?
//:
//: Notice how `let` can be used in a pattern to assign the value that matched that part of a pattern to a constant. Just like in an `if` statement, a `where` clause can be added to a case to further scope the conditional statement. However, unlike in an `if` statement, a switch case that has multiple conditions separated by commas executes when any of the conditions are met.
//:
//: After executing the code inside the switch case that matched, the program exits from the `switch` statement. Execution doesn’t continue to the next case, so you don’t need to explicitly break out of the `switch` statement at the end of each case’s code.
//:
//: Switch statements must be exhaustive. A default case is required, unless it’s clear from the context that every possible case is satisfied, such as when the switch statement is switching on an enumeration. This requirement ensures that one of the switch cases always executes.
//:
//: You can keep an index in a loop by using a `Range`. Use the _half-open range operator_ ( `..<`) to make a range of indexes.
//:
var firstForLoop = 0
for i in 0..<4 {
    firstForLoop += i
}
print(firstForLoop)

//: The half-open range operator (`..<`) doesn’t include the upper number, so this range goes from `0` to `3` for a total of four loop iterations. Use the _closed range operator_ ( `...`) to make a range that includes both values.
//:
var secondForLoop = 0
for _ in 0...4 {
    secondForLoop += 1
}
print(secondForLoop)

//: This range goes from `0` to `4` for a total of five loop iterations. The _underscore_ (`_`) represents a wildcard, which you can use when you don’t need to know which iteration of the loop is currently executing. 
//:
//: [Previous](@previous) | [Next](@next)
