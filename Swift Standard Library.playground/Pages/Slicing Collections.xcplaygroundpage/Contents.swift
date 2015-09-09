/*:
[Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
****
# Slicing Collections
You can use standard indexing operations to index and slice into collections that implement the [Sliceable](xcdoc://?url=developer.apple.com/library/etc/redirect/xcode/ios/1048/documentation/Swift/Reference/Swift_Sliceable_Protocol/index.html) protocol. When you slice into a collection, the returned value is typically related, but not the same as, the type of the object that you sliced. In the standard library, slicing operations on collection types instead produce efficient containers that represent a sub-sequence of the collection or collection slice. These slices often share many of the same methods and properties as their respective collections, but do not have their own storage. Instead, slices are _views_ into the collections they originated from. This means you can implement algorithms that work with slices without drastically growing your app's memory footprint.

For example, you can retrieve a slice containing the elements from the index 2 through the index 5 by creating a range and slicing into an existing array:
*/
let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
let numberSlice = numbers[0...5]

/*:
If you option-click on `numberSlice`, you'll notice that `numberSlice` is of type `ArraySlice<Int>`.

To make shopping faster, let's create a short list of the next few shopping list items that you could show in a glance on the user's Apple Watch. In the code below, the glanceList function checks to make sure the list isn't empty, and then slices into the `shoppingList`. In case the list has less than 3 ingredients, the `end` of the range is computed using the `advancedBy` method. The `advancedBy` method takes two arguments: the maximum offset to advance by and the limit not to index past (in this case, the end index of the array). The `advancedBy` method will only ever index up to the end index. Instead of creating a new array, it maps over the array slice and returns a dictionary representation of each ingredient. The app can send the array of ingredient dictionaries to the user's watch.
*/
func glanceList(list: [Ingredient]) -> [[String: AnyObject]] {
    if list.isEmpty { return [] }
    let end = list.startIndex.advancedBy(3, limit: list.endIndex)
    let shortList = list[0..<end]
    let serializedList = shortList.map { ingredient in
        return ingredient.dictionaryRepresentation
    }
    
    return serializedList
}

let glanceData = glanceList(shoppingList)

/*:
If a collection adopts the `MutableSliceable` protocol, you can assign back into the collection as well, replacing elements with new ones. For example, the recipe app has a feature that allows the user to pick replacement ingredients if there's something they don't like. Let's make a mutable copy of the shopping list and swap out some of the items with suitable replacements.
*/
var swappedList = shoppingList
let chiliPowder = Ingredient(name: "Chili Powder", quantity: 1, price: 2, purchased: false)
let chives = Ingredient(name: "Chives", quantity: 5, price: 1, purchased: false)
let oregano = Ingredient(name: "Oregano", quantity: 2, price: 1, purchased: true)
swappedList[3...4] = [chiliPowder, chives, oregano]
swappedList

/*:
  > **Experiment:**
  > Notice that the code above replaces two ingredients with three. With the `MutableSliceable` protocol, you replace the entire slice at once with another collection. You can, for example, replace a range of elements with an empty collection. Try removing or adding ingredients to the replacement array above and see what happens.

 **Checkpoint:**
 At this point you have learned how to process and slice collections. In the next section, you'll learn how to use protocols in the standard library to implement your own collection type.
****
[Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
*/
