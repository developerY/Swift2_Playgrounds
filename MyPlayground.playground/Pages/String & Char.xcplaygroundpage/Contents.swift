//: [Previous](@previous)

// ------------------------------------------------------------------------------------------------
// Things to know:
//
// * Strings are bridged perfectly with NSString class
//
// * All Strings are Unicode compliant
// ------------------------------------------------------------------------------------------------

// Here's a string
var str: String = "Albatross! Get your albatross here!"

// Strings have some special character constants. They are:
"\0"         // Null character
"\\"         // Backslash
"\t"         // Tab
"\n"         // Newline
"\r"         // Carriage return
"\""         // Double quote
"\'"         // Single quote
"\u{24}"       // Single-byte Unicode
"\u{2665}"     // Double-byte unicode
"\u{0001F49c}" // Four-byte unicode

// Initializing an empty string - these are equivalent to each other
var emptyString = ""
var anotherEmptyString = String()

// Use 'isEmpty' to check for empty String
if emptyString.isEmpty
{
    "Yep, it's empty"
}

// Strings are VALUE TYPES, but they're referenced for performance so they are only copied on
// modification.
func somefunc(a: String)
{
    var b = a
    b = "Changed!"
}

var originalString = "Dog!🐶"
somefunc(originalString)
originalString // not modified

// You can iterate over a string like this:
for character in originalString.characters
{
    character
}

// Characters use double-quotes to specify them, so you must be explicit if you want a Character
// instead of a String:
var notAString: Character = "t"

// There is no length or count member of string, you have to use the global function,
// countElements()
//
// This is much like calling strlen in which it iterates over the Unicode string and counts
// characters. Note that Unicode chars are different lenghts, so this is a non-trivial process.
//
// “Note also that the character count returned by countElements is not always the same as the
// length property of an NSString that contains the same characters. The length of an NSString is
// based on the number of 16-bit code units within the string’s UTF-16 representation and not the
// number of Unicode characters within the string. To reflect this fact, the length property from
// NSString is called utf16count when it is accessed on a Swift String value.”
originalString.characters.count

let unusualMenagerie = "Koala 🐨, Snail 🐌, Penguin 🐧, Dromedary 🐪"
// *40 characters!!!!*
print("unusualMenagerie has \(unusualMenagerie.characters.count) characters")

// Strings can be concatenated with strings and characters
var helloworld = "hello, " + "world"

// ------------------------------------------------------------------------------------------------
// String interpolation
//
// String interpolation refers to referencing values inside of a String. This works different from
// printf-style functions, in that String interpolation allows you to insert the values directly
// in-line with the string, rather than as additional parameters to a formatting function.
let multiplier = 3
let message = "\(multiplier) times 2.5 is \(Double(multiplier) * 2.5)"

// ------------------------------------------------------------------------------------------------
// String comparison
//
// String comparison is case-sensitive and can be compared for equality
var str1 = "We're a lot alike, you and I."
var str2 = "We're a lot alike, you and I."
str1 == str2

// You can also compare prefix and suffix equality:
str1.hasPrefix("We're")
str2.hasSuffix("I.")
str1.hasPrefix("I.")
let greeting = "Guten Tags!"
greeting[greeting.startIndex]
greeting[greeting.endIndex.predecessor()]
greeting[greeting.startIndex.successor()]

//To insert a character into a string at a specified index, use the insert(_:atIndex:) method.
var welcome = "hello"
welcome.insert("!", atIndex: welcome.endIndex)

//To insert the contents of another string at a specified index, use the insertContentsOf(_:at:) method.
welcome.insertContentsOf(" there".characters, at: welcome.endIndex.predecessor())

//To remove a character from a string at a specified index, use the removeAtIndex(_:) method.
welcome.removeAtIndex(welcome.endIndex.predecessor())

//To remove a substring at a specified range, use the removeRange(_:) method:
let range = welcome.endIndex.advancedBy(-6)..<welcome.endIndex
welcome.removeRange(range)


// ## Unicode
// ### Unicode is an international standard for encoding, representing, and processing text in different writing systems. It enables you to represent almost any character from any language in a standardized form, and to read and write those characters to and from an external source such as a text file or web page. Swift’s String and Character types are fully Unicode-compliant, as described in this section.

//: Unicode Scalars

//: Behind the scenes, Swift’s native String type is built from Unicode scalar values. A Unicode scalar is a unique 21-bit number for a character or modifier, such as U+0061 for LATIN SMALL LETTER A ("a"), or U+1F425 for FRONT-FACING BABY CHICK ("🐥").




//: [Next](@next)
