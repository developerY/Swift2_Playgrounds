//: ## Functions and Closures
//:
//: Use `func` to declare a function. Call a function by following its name with a list of arguments in parentheses. Use `->` to separate the parameter names and types from the function’s return type.
//:

//: ### Functions and Methods
//:
//: A _function_ is a reusable, named piece of code that can be referred to from many places in a program.
//:
//: Use `func` to declare a function. A function declaration can include zero or more _parameters_, written as `name: Type`, which are additional pieces of information that must be passed into the function when it’s called. Optionally, a function can have a return type, written after the `->`, which indicates what the function returns as its result. A function’s implementation goes inside of a pair of curly braces (`{}`).


func greet(name: String, day: String) -> String {
    return "Hello \(name), today is \(day)."
}

//: Call a function by following its name with a list of _arguments_ (the values you pass in to satisfy a function’s parameters) in parentheses. When you call a function, you pass in the first argument value without writing its name, and every subsequent value with its name.
//:
greet("Anna", day: "Tuesday")
greet("Bob", day: "Friday")
greet("Charlie", day: "a nice day")

//: > **Experiment**:
//: > Remove the `day` parameter. Add a parameter to include today’s lunch special in the greeting.
//:

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



//:
//: Use a tuple to make a compound value—for example, to return multiple values from a function. The elements of a tuple can be referred to either by name or by number.
//:
func calculateStatistics(scores: [Int]) -> (min: Int, max: Int, sumNum: Int) {
    var min = scores[0]
    var max = scores[0]
    var sum = 0

    for score in scores {
        if score > max {
            max = score
        } else if score < min {
            min = score
        }
        sum += score
    }

    return (min, max, sum)
}
let statistics = calculateStatistics([5, 3, 100, 3, 9])
print(statistics.sumNum)
print(statistics.2)
statistics.max;statistics.min;statistics.sumNum

//: Functions can also take a variable number of arguments, collecting them into an array.
//:
func sumOf(numbers: Int...) -> Int {
    var sum = 0
    for number in numbers {
        sum += number
    }
    return sum
}
sumOf()
sumOf(42, 597, 12)

//: > **Experiment**:
//: > Write a function that calculates the average of its arguments.
//:
//: Functions can be nested. Nested functions have access to variables that were declared in the outer function. You can use nested functions to organize the code in a function that is long or complex.
//:
func returnFifteen() -> Int {
    var y = 10
    func add() {
        y += 5
    }
    add()
    return y
}
returnFifteen()

//: Functions are a first-class type. This means that a function can return another function as its value.
//:
func makeIncrementer() -> (Int -> Int) {
    func addOne(number: Int) -> Int {
        return 1 + number
    }
    return addOne
}
var increment = makeIncrementer()
increment(7)

//: A function can take another function as one of its arguments.
//:
func hasAnyMatches(list: [Int], condition: Int -> Bool) -> Bool {
    for item in list {
        if condition(item) {
            return true
        }
    }
    return false
}
func lessThanTen(number: Int) -> Bool {
    return number < 10
}
var numbers = [20, 19, 7, 12]
hasAnyMatches(numbers, condition: lessThanTen)

//: Functions are actually a special case of closures: blocks of code that can be called later. The code in a closure has access to things like variables and functions that were available in the scope where the closure was created, even if the closure is in a different scope when it is executed—you saw an example of this already with nested functions. You can write a closure without a name by surrounding code with braces (`{}`). Use `in` to separate the arguments and return type from the body.
//:
numbers.map({
    (number: Int) -> Int in
    let result = 3 * number
    return result
})

//: > **Experiment**:
//: > Rewrite the closure to return zero for all odd numbers.
//:
//: You have several options for writing closures more concisely. When a closure’s type is already known, such as the callback for a delegate, you can omit the type of its parameters, its return type, or both. Single statement closures implicitly return the value of their only statement.
//:
let mappedNumbers = numbers.map({ number in 3 * number })
print(mappedNumbers)

//: You can refer to parameters by number instead of by name—this approach is especially useful in very short closures. A closure passed as the last argument to a function can appear immediately after the parentheses. When a closure is the only argument to a function, you can omit the parentheses entirely.
//:
let sortedNumbers = numbers.sort { $0 > $1 }
print(sortedNumbers)



//: [Previous](@previous) | [Next](@next)
