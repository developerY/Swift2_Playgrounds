//: # The Basics
//: Swift is a new programming language for iOS, OS X, and watchOS app development. Nonetheless, many parts of Swift will be familiar from your experience of developing in C and Objective-C.

//: Swift provides its own versions of all fundamental C and Objective-C types, including Int for integers, Double and Float for floating-point values, Bool for Boolean values, and String for textual data. Swift also provides powerful versions of the three primary collection types, Array, Set, and Dictionary, as described in Collection Types.

//: Like C, Swift uses variables to store and refer to values by an identifying name. Swift also makes extensive use of variables whose values cannot be changed. These are known as constants, and are much more powerful than constants in C. Constants are used throughout Swift to make code safer and clearer in intent when you work with values that do not need to change.

//: In addition to familiar types, Swift introduces advanced types not found in Objective-C, such as tuples. Tuples enable you to create and pass around groupings of values. You can use a tuple to return multiple values from a function as a single compound value.
    
//: Swift also introduces optional types, which handle the absence of a value. Optionals say either “there is a value, and it equals x” or “there isn’t a value at all”. Optionals are similar to using nil with pointers in Objective-C, but they work for any type, not just classes. Optionals are safer and more expressive than nil pointers in Objective-C and are at the heart of many of Swift’s most powerful features.

//: Optionals are an example of the fact that Swift is a type safe language. Swift helps you to be clear about the types of values your code can work with. If part of your code expects a String, type safety prevents you from passing it an Int by mistake. This restriction enables you to catch and fix errors as early as possible in the development process.



//: ------------------------------------------------------------------------------------------------
//: Things to know:
//:
//: * Swift is Apple's new programming language for iOS and OSX. If you know C or Objective-C, then
//:   these playgrounds should serve as a solid primer for making the switch to Swift.
//:
//: * Some experience programming in a C-like langauge is expected. If not, then I'm sorry but
//:   you're just not the target audience.
//: ------------------------------------------------------------------------------------------------

//: ------------------------------------------------------------------------------------------------
//: Constants & Variables - These are known as "Stored Values" in Swift

//: Use the 'let' keyword to define a constant
let maximumNumberOfLoginAttempts = 10

//: Use the 'var' keyword to define a variable
//:
//: Tip: only use variables when you need a stored value that changes. Otherwise, prefer constants.
var currentLoginAttempt = 0

//: Constants cannot change. This line wouldn't compile:
//: maximumNumberOfLoginAttempts = 9

//: Variables can change:
currentLoginAttempt += 1

//: You also can't redeclare a variable or constant once it has been declared. These lines
//: won't compile:
//: let maximumNumberOfLoginAttempts = 10
//: var currentLoginAttempt = "Some string which is not an Int"

//: You can combine them on a single line with a comma
let a = 10, b = 20, c = 30
var x = 0.0, y = 0.0, z = 0.0

//: Specifying the type with type annotations
//:
//: The built-in types in Swift are: Int, Double, Float, Bool, String, Array, Dictionary
//: There are variations of these (like UInt16), but those are the basic types. Note that all of
//: these types are capitalized.
//:
//: Because of inference (assuming 42 is an Int an "some text" is a String), type annotations are
//: usually pretty rare in Swift
//:
//: Here's how you specify the type. If we didn't specify the type as Double, tye type would have
//: been inferred to be Int.
var SomeDouble: Double = 4

//: Constant & Variable names cannot contain any mathematical symbols, arrows private-use (or
//: invalid) Unicode code points or line-and-box drawing characters. Nor can they begin with a
//: number. Otherwise, it's open season for naming your variables! (yes, really!)
//:
//: Here are some oddly named, but perfectly valid, constants:
let π = 3.14159
let 你好 = "你好世界"
let 🐶🐮 = "dogcow"

//: You can print a value using println
let fiveHundred = 500
print("The current value of fiveHundred is: \(fiveHundred)")

//: Since we're using Playgrounds, we'll just put the raw string on the line which is an expression
//: that evaluates to itself, printing the result in the right-hand pane in the playground, like so:
"The current value of fiveHundred is: \(fiveHundred)"

//: ------------------------------------------------------------------------------------------------
//: A note about variable names
//:
//: As with most languages, you cannot give an identifier (such as a variable or constant name,
//: class name, etc.) the same name as a keyword. For example, you can't define a constant named
//: "let":
//:
//: The following line of code will not compile:
//:
//: let let = 0
//:
//: However, sometimes it would be convenient to do so and Swift provides a means to enable this
//: by surrounding the identifier with backticks (`). Here's an example:
let `let` = 42.0

//: We can now use `let` like any normal variable:
x = `let`

//: This works for any keyword:
let `class` = "class"
let `do` = "do"
let `for` = "for"

//: Additionally, it's important to know that this works on non-colliding identifier names:
let `myConstant` = 123.456

//: Also note that `myConstant` and myConstant refer to the same constant:
myConstant

//: ### Printing Constants and Variables

//: You can print the current value of a constant or variable with the print(_:separator:terminator:) function:
var friendlyWelcome = "Hello!"
friendlyWelcome = "Bonjour!"
print(friendlyWelcome)
// prints "Bonjour!"

//: Swift uses string interpolation to include the name of a constant or variable as a placeholder in a longer string, and to prompt Swift to replace it with the current value of that constant or variable. Wrap the name in parentheses and escape it with a backslash before the opening parenthesis:

print("The current value of friendlyWelcome is \(friendlyWelcome)")


//: ------------------------------------------------------------------------------------------------
//: Comments
//:
//: You've probably already figured this out, but anything after the "//:" is a comment. There's more
//: to comments, though:

/* This is a comment
that spans multiple lines */

//: The multi-line comments are handy because they can nest, which allows you to safely comment out
//: blocks of code, even if they have multi-line comments in them:

/*
//: Some variable
var someVar = 10

/* A function
*
* This is a common way to comment functions, but it makes it difficult to comment out these
* blocks.
*/
func doSomething()
{
return
}
*/

//: ------------------------------------------------------------------------------------------------
//: Semicolons
//:
//: Semicolons on the end of a line are optional, but the preferred style for Swift is to not use
//: them to terminate lines.
var foo1 = 0
var foo2 = 0; //: optional semicolon

//: However, if you want to put two lines of code on one line, you'll need the semicolon to separate
//: them.
foo1 = 1; foo2 = 2

//: ------------------------------------------------------------------------------------------------
//: Integers
//:
//: There are multiple types of integers. Signed and unsigned with sizes of 8, 16, 32 and 64 bits.
//: Here are a couple samples:
let meaningOfLife: UInt8 = 42 //: Unsigned 8-bit integer
let randomNumber: Int32 = -34 //: Signed 32-bit integer

//: There is also Int and UInt, the defaults. These will default to the size of the current
//: platform's native word size. On 32-bit platforms, Int will be equivalent to Int32/UInt32. On
//: 64-bit platforms it is equivalent to Int64/UInt64.
//:
//: Similarly, there is
//:
//: Tip: For code interoperability, prefer Int over its counterparts.
let tirePressurePSI = 52

//: To find the bounds of any integer, try ".min" or ".max"
UInt8.min
UInt8.max
Int32.min
Int32.max

//: ------------------------------------------------------------------------------------------------
//: Floating point numbers
//:
//: Double is a 64-bit floating point numbers and Float is a 32-bit floating point number
let pi: Double = 3.14159
let pie: Float = 100 //: ... becase it's 100% delicious!

//: ### Type Safety and Type Inference

//: Swift is a type safe language. A type safe language encourages you to be clear about the types of values your code can work with. If part of your code expects a String, you can’t pass it an Int by mistake.

//: Because Swift is type safe, it performs type checks when compiling your code and flags any mismatched types as errors. This enables you to catch and fix errors as early as possible in the development process.

//: Type-checking helps you avoid errors when you’re working with different types of values. However, this doesn’t mean that you have to specify the type of every constant and variable that you declare. If you don’t specify the type of value you need, Swift uses type inference to work out the appropriate type. Type inference enables a compiler to deduce the type of a particular expression automatically when it compiles your code, simply by examining the values you provide.

//: Because of type inference, Swift requires far fewer type declarations than languages such as C or Objective-C. Constants and variables are still explicitly typed, but much of the work of specifying their type is done for you.

//: Type inference is particularly useful when you declare a constant or variable with an initial value. This is often done by assigning a literal value (or literal) to the constant or variable at the point that you declare it. (A literal value is a value that appears directly in your source code, such as 42 and 3.14159 in the examples below.)

//: For example, if you assign a literal value of 1234 to a new constant without saying what type it is, Swift infers that you want the constant to be an Int, because you have initialized it with a number that looks like an integer://:
//: Integer literals are inferred to be Int
let someInt = 1234

//: Floating point literals are always inferred to be Double
let someDouble = 1234.56

//: If you want a Float instead, you must use type annotation
let someFloat: Float = 1234.56

//: String literals are inferred to be String type
let someString = "This will be a String"

//: Here's a bool
let someBool = true

//: These lines won't compile because we are specifying a type that doesn't match the given value
//: let someBool: Bool = 19
//: let someInteger: Int = "45"
//: let someOtherInt: Int = 45.6

//: ### Numeric Literals

//: Integer literals can be written as:

/*:
* A decimal number, with no prefix
* A binary number, with a 0b prefix
* An octal number, with a 0o prefix
* A hexadecimal number, with a 0x prefix
*/

//: You can specify numbers in a few interesting ways
let decimalInteger = 17
let binaryInteger = 0b10001 // 17 in binary notation
let octalInteger = 0o21 // ...also 17 (Octal, baby!)
let hexInteger = 0x11 // ...and 17 in Hexidecimal

//: Floating point numbers can be specified in a few different ways as well. Here are a few raw
//: examples (not assigned to variables):
1.25e2 //: Scientific notation
1.25e-2
0xFp2 //: Break this down into "0xF", "p", "2". Read as 15 (0xF) to the power of (p) 2, which is 60
0xFp-2
0xC.3p0

//: We can pad our literals as well:
000123.456 //: Zero padding
0__123.456 //: Underscores are just ignored

//: ###Numeric Type Conversion
/*:
* Use the Int type for all general-purpose integer constants and variables in your code, even if they are known to be non-negative. Using the default integer type in everyday situations means that integer constants and variables are immediately interoperable in your code and will match the inferred type for integer literal values.

* Use other integer types only when they are specifically needed for the task at hand, because of explicitly-sized data from an external source, or for performance, memory usage, or other necessary optimization. Using explicitly-sized types in these situations helps to catch any accidental value overflows and implicitly documents the nature of the data being used.
*/
//: Integer Conversion

//: The range of numbers that can be stored in an integer constant or variable is different for each numeric type. An Int8 constant or variable can store numbers between -128 and 127, whereas a UInt8 constant or variable can store numbers between 0 and 255. A number that will not fit into a constant or variable of a sized integer type is reported as an error when your code is compiled:


//: Since the default type for numeric values is Int, you need to specify a different type
let simpleInt = 2_000 // Int
let twoThousand: UInt16 = 2_000 // Specified as UInt16
let one: UInt8 = 1 // Specified as UInt8

//: This will infer a UInt16 based on the types of both operands
let twoThousandAndOne = twoThousand + UInt16(one)

//: Conversions between integer and floating point types must be made explicit
let three = 3 //: Inferred to be Int
let pointOneFourOneFiveNine = 0.14159 //: Inferred to be Double
let doublePi = Double(three) + pointOneFourOneFiveNine //: Explicit conversion of Int to Double

//: The inverse is also true - conversion from floating point to integer must be explicit
//:
//: Conversions to integer types from floating point simply truncate the fractional part. So
//: doublePi becomes 3 and -doublePi becomes -3
let integerPi = Int(doublePi)
let negativePi = Int(-doublePi)

//: Literal numerics work a little differently since the literal values don't have an explicit
//: type assigned to them. Their type is only inferred at the point they are evaluated.
let someValue = 3 + 0.14159

//: ------------------------------------------------------------------------------------------------
//: Things to know:
//:
//: * Type Aliases allow you to provide a different name for types,
//:   similar to 'typedef' in C.
//: ------------------------------------------------------------------------------------------------

// Create an alias for UInt16 called "AudioSample"
typealias AudioSample = UInt16

// This actually calls UInt16.min
var maxAmplituedFound = AudioSample.min

// We can also typealias custom types
struct MySimpleStruct
{
    static let a = 99
}

typealias MyAliasedName = MySimpleStruct
MyAliasedName.a

//:  ### Booleans

//: Swift has a basic Boolean type, called Bool. Boolean values are referred to as logical, because they can only ever be true or false. Swift provides two Boolean constant values, true and false:

let orangesAreOrange = true
let turnipsAreDelicious = false

//: ### Tuples

//: Tuples group multiple values into a single compound value. The values within a tuple can be of any type and do not have to be of the same type as each other.

//: In this example, (404, "Not Found") is a tuple that describes an HTTP status code. An HTTP status code is a special value returned by a web server whenever you request a web page. A status code of 404 Not Found is returned if you request a webpage that doesn’t exist.



//: ------------------------------------------------------------------------------------------------
//: Things to know:
//:
//: * Tuples are groups of values combined into a single, compound value
//: ------------------------------------------------------------------------------------------------

//: Defining a Tuple - use parenthesis around the comma-delimited list of values
//:
//: This Tuple doesn't specify types, so it relies on inference
let httpError404 = (404, "Not found")

//: We can also specify the type in order to avoid inferrence
let someOtherTuple = (Double(100), Bool(false))

//: Decomposing typles looks like this
let (statusCode, statusMessage) = httpError404
statusCode
statusMessage

//: We can also decompose into variables instead of constants, but you probably figured that out
var (varStatusCode, varStatusMessage) = httpError404
varStatusCode
varStatusMessage

//: You can also access them with the dot operator followed by their index:
httpError404.0
httpError404.1

//: Alternatively, you can name the elements of a Tuple
let namedTuple = (statusCode: 404, message: "Not found")

//: When you name the elements you effectively assign names to their indices, so the dot operator
//: works with names or integers:
namedTuple.statusCode == namedTuple.0
namedTuple.message == namedTuple.1

// tuples can hold more then two and mixed type
let mix = ("one", 1, "two", 2, true)
mix

