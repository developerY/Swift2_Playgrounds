func needToBuy(ingredient: Ingredient) -> Bool {
    return !ingredient.purchased
}

public let shoppingList = sampleIngredients.filter(needToBuy)
