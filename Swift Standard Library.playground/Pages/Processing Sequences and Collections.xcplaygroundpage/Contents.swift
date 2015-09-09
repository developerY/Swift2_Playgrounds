/*:
[Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
****
# Processing Sequences and Collections
Sequences and collections implement functions such as `map`, `filter`, and `reduce` to consume and transform their contents. You can compose these functions together to efficiently implement complex algorithms.

The `filter` function takes a collection and returns an array containing only the elements that pass the provided test. Let's create a shopping list by filtering out ingredients that have already been purchased.
*/
let shoppingList = sampleIngredients.filter { ingredient in
    return !ingredient.purchased
}
visualize(sampleIngredients, shoppingList)

/*:
The `map` function takes an array and returns a new array by applying a `transform` to each element in the array. For example, the following code multiplies the quantity of the ingredient by the cost of the ingredient to find the total cost for each ingredient.
*/
let totalPrices = shoppingList.map { ingredient in
    return ingredient.quantity * ingredient.price
}
visualize(shoppingList, totalPrices)

/*:
You can use the `reduce` function to combine elements of an array into a single value. The `reduce` function takes an initial value to start with and then a function to combine each element in the array with the previous value. The following code takes the total price list and adds them together to compute a final remaining cost:
*/
let sum = totalPrices.reduce(0) { currentPrice, priceToAdd in
    return currentPrice + priceToAdd
}
sum

/*:
  > **Experiment:**
  > Try changing the initial value from `0` to another number. How does this affect the final sum?

The `map`, `filter`, and `reduce` functions compose naturally, so you can collapse the code above into a single function. The following code example implements the `remainingCost` function, used by the app to display the remaining cost for a recipe.
*/
func remainingCost(list: [Ingredient]) -> Int {
    return list.filter { !$0.purchased }.map { $0.quantity * $0.price }.reduce(0) { $0 + $1 }
}
let cost = remainingCost(sampleIngredients)

/*:
There are many more generic algorithms in the standard library similar to those above that you can compose together.

 > **Checkpoint:**
 > At this point you have learned how to process sequences and collections and why value semantics make it easier to reason about the code you write. In the next section, you'll learn how to use ranges to slice into collections.

[Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
*/
