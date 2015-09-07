//: [Previous](@previous)

// ------------------------------------------------------------------------------------------------
// Things to know:
//
// * An optional value is a stored value that can either hold a value or "no value at all"
//
// * This is similar to assigning a stored value to "nil" but Optionals work with any type of
//   stored value, including Int, Bool, etc.
// ------------------------------------------------------------------------------------------------

// An optional declaration adds a "?" immediately after the explicit type. The following line
// defines a value 'someOptional' that can either hold an Int or no value at all. In this case
// we set an optional Int value to .None (similar to nil)
let someOptional: Int? = .None

// Let's try to convert a String to an Int
//
// Using the String's toInt() method, we'll try to convert a string to a numeric value. Since not
// all strings can be converted to an Integer, the toInt() returns an optional, "Int?". This way
// we can recognize failed conversions without having to trap exceptions or use other arcane
// methods to recognize the failure.
//
// Here's an optional in action
let notNumber = "abc"
let failedConversion = Int(notNumber)

// Notice how failedConversion is 'nil', even though it's an Int
failedConversion

// Let's carry on with a successful conversion
let possibleNumber = "123"
var optionalConvertedNumber = Int(possibleNumber)

// This one worked
optionalConvertedNumber

// If we assign it to a constant, the type of that constant will be an Optional Int (Int?)
let unwrapped = optionalConvertedNumber // 'unwrapped' is another optional

// ------------------------------------------------------------------------------------------------
// Alternate syntax for Optionals
//
// The use of a "?" for the syntax of an optional is syntactic sugar for the use of the Generic
// Optional type defined in Swift's standard library. We haven't gotten into Generics yet, but
// let's not let that stop us from learning this little detail.
//
// These two lines are of equivalent types:
let optionalA: String? = .None
let optionalB: Optional<String> = .None

// ------------------------------------------------------------------------------------------------
// Unwrapping
//
// The difference between Int and Int? is important. Optionals essentially "wrap" their contents
// which means that Int and Int? are two different types (with the latter being wrapped in an
// optional.
//
// We can't explicity convert to an Int because that's not the same as an Int?. The following
// line won't compile:
//
// let unwrappedInt: Int = optionalConvertedNumber

// One way to do this is to "force unwrap" the value using the "!" symbol, like this:
let unwrappedInt = optionalConvertedNumber!

// Implicit unwrapping isn't very safe because if the optional doesn't hold a value, it will
// generate a runtime error. To verify that is's safe, you can check the optional with an if
// statement.
if optionalConvertedNumber != .None
{
    // It's now safe to force-unwrap because we KNOW it has a value
    let anotherUnwrappedInt = optionalConvertedNumber!
}
else
{
    // The optional holds "no value"
    "Nothing to see here, go away"
}

// ------------------------------------------------------------------------------------------------
// Optional Binding
//
// We can conditionally store the unwrapped value to a stored value if the optional holds a value.
//
// In the following block, we'll optionally bind the Int value to a constant named 'intValue'
if let intValue = optionalConvertedNumber
{
    // No need to use the "!" suffix as intValue is not optional
    intValue
    
    // In fact, since 'intValue' is an Int (not an Int?) we can't use the force-unwrap. This line
    // of code won't compile:
    // intValue!
}
else
{
    // Note that 'intValue' doesn't exist in this "else" scope
    "No value"
}

// We can still use optional binding to bind to another optional value, if we do so explicitly
// by specifying the type of the stored value that we're binding to.
if let optionalIntValue:Int? = optionalConvertedNumber
{
    // 'optionalIntValue' is still an optional, but it's known to be safe. We can still check
    // it here, though, because it's still an optional. If it weren't optional, this if statement
    // wouldn't compile:
    if optionalIntValue != .None
    {
        // 'optionalIntValue' is optional, so we still use the force-unwrap here:
        "intValue is optional, but has the value \(optionalIntValue!)"
    }
}

// Multiple optional bindings can appear in a single if statement as a comma-separated list of assignment expressions.
if let optionalIntValue:Int? = optionalConvertedNumber , optionalIntValue2:Int? = optionalConvertedNumber, optionalIntValue3:Int? = optionalConvertedNumber
{
    print("silly example")
}

// Setting an optional to 'nil' sets it to be contain "no value"
optionalConvertedNumber = nil

// Now if we check it, we see that it holds no value:
if optionalConvertedNumber != .None
{
    "optionalConvertedNumber holds a value (\(optionalConvertedNumber))! (this should not happen)"
}
else
{
    "optionalConvertedNumber holds no value"
}

// We can also try optional binding on an empty optional
if let optionalIntValue = optionalConvertedNumber
{
    "optionalIntValue holds a value (\(optionalIntValue))! (this should not happen)"
}
else
{
    "optionalIntValue holds no value"
}

// Because of the introduction of optionals, you can no longer use nil for non-optional
// variables or constants.
//
// The following line will not compile
//
// var failure: String = nil // Won't compile

// The following line will compile, because the String is optional
var noString: String? = nil

// If we create an optional without an initializer, it is automatically initialized to nil. In
// future sections, we'll learn that all values must be initialized before they are used. Because
// of this behavior, this variable is considered initialized, even though it holds no value:
var emptyOptional: String?

// Another way to implicitly unwrap an optional is during declaration of a new stored value
//
// Here, we create an optional that we are pretty sure will always hold a value, so we give Swift
// permission to automatically unwrap it whenever it needs to.
//
// Note the type, "String!"
let possibleString: String? = "An optional string."
let forcedString: String = possibleString! // requires an exclamation mark

var assumedString: String! = "An implicitly unwrapped optional string."
let implicitString: String = assumedString // no need for an exclamation mark

// Although assumedString is still an optional (and can be treated as one), it will also
// automatically unwrap if we try to use it like a normal String.
//
// Note that we perform no unwrapping in order to assign the value to a normal String
let copyOfAssumedString: String = assumedString

// Since assumedString is still an optional, we can still set it to nil. This is dangerous to do
// because we assumed it is always going to hold a value (and we gave permission to automatically
// unwrap it.) So by doing this, we are taking a risk:
assumedString = nil

// BE SURE that your implicitly unwrapped optionals actually hold values!
//
// The following line will compile, but will generate a runtime error because of the automatic
// unwrapping.
//
// let errorString: String = assumedString

// Like any other optional, we can still check if it holds a value:
if assumedString != nil
{
    "We have a value"
}
else
{
    "No value"
}

// ### Error Handling

// You use error handling to respond to error conditions your program may encounter during execution.
    
// In contrast to optionals, which can use the presence or absence or a value to communicate success or failure of a function, error handling allows you to determine the underlying cause of failure, and, if necessary, propagate the error to another part of your program.

// When a function encounters an error condition, it throws an error. That function’s caller can then catch the error and respond appropriately.


// When a function encounters an error condition, it throws an error. That function’s caller can then catch the error and respond appropriately.

func canThrowAnError() throws {
    // this function may or may not throw an error
}

// A function indicates that it can throw an error by including the throws keyword in its declaration. When you call a function that can throw an error, you prepend the try keyword to the expression.

// Swift automatically propagates errors out of their current scope until they are handled by a catch clause.

do {
    try canThrowAnError()
    // no error was thrown
} catch {
    // an error was thrown
}

// A do statement creates a new containing scope, which allows errors to be propagated to one or more catch clauses.
// Here’s an example of how error handling can be used to respond to different error conditions:

func makeASandwich() throws {
    // ...
}
/*
do {
    try makeASandwich()
    eatASandwich()
} catch Error.OutOfCleanDishes {
    washDishes()
} catch Error.MissingIngredients(let ingredients) {
    buyGroceries(ingredients)
}
*/



// ------------------------------------------------------------------------------------------------
// Things to know:
//
// * Assertions only trigger in debug mode and not in published builds
//
// * Assertions cause your app to terminate on the line and the debugger jumps to the line
// ------------------------------------------------------------------------------------------------

// Let's start with a value...
let age = 3

// You can assert with a message
assert(age >= 0, "A person's age cannot be negative")

// You can assert without the message
assert(age >= 0)

//:  ### When to Use Assertions

//: Use an assertion whenever a condition has the potential to be false, but must definitely be true in order for your code to continue execution. Suitable scenarios for an assertion check include:
/*:
* An integer subscript index is passed to a custom subscript implementation, but the subscript index value could be too low or too high.
* A value is passed to a function, but an invalid value means that the function cannot fulfill its task.
* An optional value is currently nil, but a non-nil value is essential for subsequent code to execute successfully.
*/

//: [Next](@next)
