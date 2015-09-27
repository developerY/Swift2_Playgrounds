//: [Previous](@previous)

import UIKit

//: # Collections
//: *In Swift, the collection clearly know the type of value it can store, so if you insert a wrong type, an error.*

/*:
* ### Array: an ordered value stored
* ### Set: storage disorder unique value
* ### Dictionary: storage disorderly key-value key pairs
*/

var image = UIImage (named: "collectionTypes")

//: Mutability of Collections
// Use var, let distinguish whether a variable

//: ## Array
//:
//: ### Arrays are ordered lists of elements
//:
//: * The types of values that can be stored in an array must always be made clear either through
//:   explicit type annotation or through type inference and does not have to be a base class type.
//: ----
//: * Arrays are type-safe and always clear about what they contain.
//: ----
//: * Arrays are value types, but Swift is smart about only copying when necessary to improve
//:   performance.
//: ----
//: * Immutable arrays are immutable in terms of the array itself and the contents of the array.
//:   This means you can't add/remove an element nor can you modify an element of an immutable
//:   array.
//: ------------------------------------------------------------------------------------------------



//: Create an array of Strings
var someArray = Array<String>()

//: *Shorter, more common way to define an array of Strings*
var shorter: [String]

//: This is an array literal. Since all members are of type String, this will create a String array.
//:
//: If all members are ***not the same*** type (or cannot be inferred to a homogenized type) then you
//: would ***get a compiler error***.
["Eggs", "Milk"]

//: Let's create an array with some stuff in it. We'll use an explicit String type:
var commonPets: [String] = ["Cats", "Dogs"]

//: We can also let Swift infer the type of the Array based on the type of the initializer members.
//:
//: The folowing is an array of Strings
var shoppingList = ["Eggs", "Milk"]

//: ------------------------------------------------------------------------------------------------
//:
//: ### Accessing and modifying an Array
//:
//: We can get the number of elements
shoppingList.count

//: We can check to see if it's empty
if !shoppingList.isEmpty { "it's not empty" }

//: We can append to the end
shoppingList.append("Flour")
shoppingList.append("Baking Powder")
shoppingList.count

//: We can append another array of same type
shoppingList += ["Chocolate Spread", "Cheese", "Butter"]
shoppingList.count

//: We can get elements from the array by indexing them
shoppingList[0]
shoppingList[1]

//: We can modify an existing item
shoppingList[0] = "Six Eggs"

//: We can use a range operator to modify existing items. This operation modifies a range with
//: a target range. If the target range has more or fewer elements in it, the size of the array
//: will be adjusted.
//:
//: Here, we replace 3 items with only two, removing an item:
shoppingList
shoppingList[4...6] = ["Banannas", "Apples"]
shoppingList

//: Or we can replace two items with three, inserting a new item:
shoppingList[4..<6] = ["Limes", "Mint leaves", "Sugar"]

//: We can insert an item at a given index
shoppingList.insert("Maple Syrup", atIndex: 3)

//: We can remove the last element. During this, we can preserve the value of what was removed
//: into a stored value
let apples = shoppingList.removeLast()
//: or removeAtIndex

let eggs = shoppingList.removeAtIndex(0)

//: ***NOTE***
//: If you try to access or modify a value for an index that is outside of an array’s existing bounds, you will trigger a runtime error. However, you can check that an index is valid before using it, by comparing it to the array’s count property. Except when count is 0 (meaning the array is empty), the largest valid index in an array will always be count - 1, because arrays are indexed from zero.
//let bad = shoppingList.removeAtIndex(100)

//: ------------------------------------------------------------------------------------------------
//: ### Enumeration
//:
//: We can iterate over the the array using a for-in loop
for item in shoppingList
{
    item
}

//: We can also use the the enumerate() method to return a tuple containing the index and value
//: for each element:
for (index, value) in shoppingList.enumerate() {
    print("Item \(index + 1): \(value)")
}

//: ------------------------------------------------------------------------------------------------
//: ### Creating and initializing an array
//:
//: Earlier, we saw how to declare an array of a given type. Here, we see how to declare an array
//: type and then assign it to a stored value, which gets its type by inference:
var someInts = [Int]()

//: Add the number '3' to the array
someInts.append(3)
someInts

//: We can assign it to an empty array, but we don't modify the type, since someInts is already
//: an Int[] type.
someInts = []

//: We can initialize an array and and fill it with default values
var threeDoubles = [Double](count: 3, repeatedValue: 3.3)

//: We can also use the Array initializer to fill it with default values. Note that we don't need to
//: specify type since it is inferred:
var anotherThreeDoubles = Array(count: 3, repeatedValue: 2.5)

//: If you store an array in a constant, it is considered "Immutable"
let immutableArray = ["a", "b"]

//: In terms of immutability, it's important to consider that the array and its contents are treated
//: separately. Therefore, you can change the contents of an immutable array, but you can't change
//: the array itself.
//:
//: We can't change the contents of an immutable array:
//:
//: immutableArray[0] = "b"
//:
//: Nor can we change the size or add an element, you will get a compiler error:
//:
//: immutableArray += "c"

//: ------------------------------------------------------------------------------------------------
//: Arrays are Value Types
//:
//: Arrays are value types that only copy when necessary, which is only when the array itself
//: changes (not the contents.)
//:
//: Here are three copies of an array:
var a = [1, 2, 3]
var b = a
var c = a

//: However, if we change the contents of one array (mutating it), then it is copied and becomes its
//: own unique entity:
a[0] = 42
b[0]
c[0]

//: The same is true if we mutate the array in other ways (mofify the array's size)...
b.append(4)

//: Now, we have three different arrays...
a
b
c



//: # Dictionaries
//: *A dictionary stores associations between keys of the same type and values of the same type in a collection with no defined ordering. Each value is associated with a unique key, which acts as an identifier for that value within the dictionary. Unlike items in an array, items in a dictionary do not have a specified order. You use a dictionary when you need to look up values based on their identifier, in much the same way that a real-world dictionary is used to look up the definition for a particular word.*

//: Notes:
//: * Dictionaries store multiple values of the same type, each associated with a key which acts as  an identifier for that value within the dictionary.
//: * Dictionaries are type-safe and always clear about what they contain.
//: * The types of values that can be stored in a dictionary must always be made clear either through explicit type annotation or through type inference.


//: ------------------------------------------------------------------------------------------------
//: Creating a dictionary
//:
//: This is a Dictionary literal. They contain a comma-separated list of **key:value pairs**:
["TYO": "Tokyo", "DUB": "Dublin"]

// literal to define and initialize a Dictionary.
// This uses the syntactic sugar "[ KeyType: ValueType ]" to declare the dictionary.
var airports: [String : String] = ["TYO": "Tokyo", "DUB": "Dublin", "APL": "Apple Intl"]

// The declaration for airports above could also have been declared in this way:
var players: Dictionary<String, String> = ["Who" : "First", "What" : "Second"]

//inference works in our favor allowing us to avoid the type annotation:
let inferredDictionary = ["TYO": "Tokyo", "DUB": "Dublin"]

//: ------------------------------------------------------------------------------------------------
//: Accessing and modifying a Dictionary
//:
// get a value from the dictionary for the TYO airport:
airports["TYO"]
// chang the value
airports["TYO"] = "Tokyo Airport"
// update 
airports.updateValue("Dublin Airport", forKey: "DUB")
airports

// removed
airports["APL"] = nil
let removedValue = airports.removeValueForKey("DUB")

//: ### Iterating over key/value pairs with a for-in loop, which uses a Tuple to hold the
//: key/value pair for each entry in the Dictionary:
for (airportCode, airportName) in airports
{
    airportCode
    airportName
}

// We can iterate over just the keys
for airportCode in airports.keys
{
    airportCode
}

// We can iterate over jsut the values
for airportName in airports.values
{
    airportName
}

// test empty
if airports.isEmpty {
    print("The airports dictionary is empty.")
}


// get count
print("The airports dictionary contains \(airports.count) items.")

//: We can create an array from the keys or values
//:
//: Note that when doing this, the use of Array() is needed to convert the keys or values into
//: an array.
var airportCodes = [String](airports.keys)
var airportNames = [String](airports.values)
// do not use the old way
airportCodes = Array(airports.keys)
airportNames = Array(airports.values)


//: ------------------------------------------------------------------------------------------------
//: Creating an empty Dictionary
//:
//: Here, we create an empty Dictionary of Int keys and String values:
var namesOfIntegers = Dictionary<Int, String>()

// Let's set one of the values
namesOfIntegers[16] = "Sixteen"

// We can empty a dictionary using an empty dictionary literal:
namesOfIntegers = [:]
namesOfIntegers.count

// An immutable dictionary is a constant.
let immutableDict = ["a": "one", "b": "two"]

//: Similar to arrays, we cannot modify the contents of an immutable dictionary. The following lines
//: will not compile:
//:
// immutableDict["a"] = "b" // You cannot modify an element
// immutableDict["c"] = "three" // You cannot add a new entry or change the size

//: *Dictionaries are value types, which means they are copied on assignment.*
//
// Let's create a Dictionary and copy it:
var ages = ["Peter": 23, "Wei": 35, "Anish": 65, "Katya": 19]
var copiedAges = ages

// Next, we'll modify the copy:
copiedAges["Peter"] = 24

// And we can see that the original is not changed:
ages["Peter"]



//: [Next](@next)
