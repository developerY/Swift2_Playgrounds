//: [Previous](@previous)

import UIKit

//: ## Set
//:
//: #### A set stores distinct values of the same type in a collection with no defined ordering. You can use a set instead of an array when the order of items is not important, or when you need to ensure that an item only appears once.

//: *Hash Values for Set Types A type must be hashable in order to be stored in a set—that is, the type must provide a way to compute a hash value for itself. A hash value is an Int value that is the same for all objects that compare equally, such that if a == b, it follows that a.hashValue == b.hashValue.*

//: Creating and Initializing an Empty Set
//: You can create an empty set of a certain type using initializer syntax:

var letters = Set<Character>()
print("letters is of type Set<Character> with \(letters.count) items.")

// adds a
letters.insert("a")
// empty
letters = []

//: The example below creates a set called favoriteGenres to store String values:
var favoriteGenres: Set<String> = ["Rock", "Classical", "Hip hop"]

//: ### Accessing and Modifying a Set
print("I have \(favoriteGenres.count) favorite music genres.")

// check empty
if favoriteGenres.isEmpty {
    print("As far as music goes, I'm not picky.")
} else {
    print("I have particular music preferences.")
}

// insert
favoriteGenres.insert("Jazz")

// remove
let removedGenre = favoriteGenres.remove("Rock")

// contains
if favoriteGenres.contains("Jazz") {
    print("I get up on the good foot.")
}

//: ### Iterating Over a Set
// even sort
for genre in favoriteGenres.sort() {
    print("\(genre)")
}

//: ### Performing Set Operations
//:
//: You can efficiently perform fundamental set operations, such as combining two sets together, determining which values two sets have in common, or determining whether two sets contain all, some, or none of the same values.

//: *Fundamental Set Operations*
//: *The illustration below depicts two sets–a and b– with the results of various set operations represented by the shaded regions.*

var image = UIImage(named: "SetOperations")
/*:
* Use the intersect(_:) method to create a new set with only the values common to both sets.
* Use the exclusiveOr(_:) method to create a new set with values in either set, but not both.
* Use the union(_:) method to create a new set with all of the values in both sets.
* Use the subtract(_:) method to create a new set with values not in the specified set.
*/

let oddDigits: Set = [1, 3, 5, 7, 9]
let evenDigits: Set = [0, 2, 4, 6, 8]
let singleDigitPrimeNumbers: Set = [2, 3, 5, 7]

oddDigits.union(evenDigits).sort()

oddDigits.intersect(evenDigits).sort()

oddDigits.subtract(singleDigitPrimeNumbers).sort()

oddDigits.exclusiveOr(singleDigitPrimeNumbers).sort()

//: ### Set Membership and Equality
//: *The illustration below depicts three sets–a, b and c– with overlapping regions representing elements shared among sets. Set a is a superset of set b, because a contains all elements in b. Conversely, set b is a subset of set a, because all elements in b are also contained by a. Set b and set c are disjoint with one another, because they share no elements in common.*

image = UIImage(named: "setEulerDiagram")

/*:
* Use the “is equal” operator (==) to determine whether two sets contain all of the same values.
* Use the isSubsetOf(_:) method to determine whether all of the values of a set are contained in the specified set.
* Use the isSupersetOf(_:) method to determine whether a set contains all of the values in a specified set.
* Use the isStrictSubsetOf(_:) or isStrictSupersetOf(_:) methods to determine whether a set is a subset or superset, but not equal to, a specified set.
* Use the isDisjointWith(_:) method to determine whether two sets have any values in common.
*/

let houseAnimals: Set = ["🐶", "🐱"]
let farmAnimals: Set = ["🐮", "🐔", "🐑", "🐶", "🐱"]
let cityAnimals: Set = ["🐦", "🐭"]

houseAnimals.isSubsetOf(farmAnimals)

farmAnimals.isSupersetOf(houseAnimals)

farmAnimals.isDisjointWith(cityAnimals)
//: [Next](@next)
