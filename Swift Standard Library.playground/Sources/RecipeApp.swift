import UIKit

public struct Ingredient: Equatable {
    public let name: String
    public let quantity: Int
    public let price: Int
    public let purchased: Bool
    public init(name: String, quantity: Int, price: Int, purchased: Bool) {
        self.name = name
        self.quantity = quantity
        self.price = price
        self.purchased = purchased
    }
    
    public var dictionaryRepresentation: [String: AnyObject] {
        get {
            return [
                "name": name,
                "quantity": quantity,
                "price": price,
                "purchased": purchased
            ]
        }
    }
}

public func == (lhs: Ingredient, rhs: Ingredient) -> Bool {
    return lhs.name == rhs.name && lhs.price == rhs.price && lhs.purchased == rhs.purchased
}

public let sampleIngredients: [Ingredient] = [
    Ingredient(name: "Tomato", quantity: 1, price: 2, purchased: false),
    Ingredient(name: "Saffron", quantity: 1, price: 6, purchased: false),
    Ingredient(name: "Chicken", quantity: 2, price: 3, purchased: true),
    Ingredient(name: "Rice", quantity: 1, price: 2, purchased: false),
    Ingredient(name: "Onion", quantity: 2, price: 1, purchased: true),
    Ingredient(name: "Garlic", quantity: 4, price: 1, purchased: false),
    Ingredient(name: "Pepper", quantity: 2, price: 3, purchased: false),
    Ingredient(name: "Salt", quantity: 1, price: 1, purchased: false)
]

@available(iOS 9.0, *)
class MapCell: UITableViewCell {
    let leftTextLabel = UILabel()
    let middleTextLabel = UILabel()
    let rightTextLabel = UILabel()
    let stack = UIStackView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        middleTextLabel.text = "→"
        middleTextLabel.textAlignment = .Center
        middleTextLabel.font = UIFont.boldSystemFontOfSize(20)
        rightTextLabel.textAlignment = .Right
        stack.distribution = UIStackViewDistribution.FillEqually
        stack.frame = self.contentView.bounds
        stack.addArrangedSubview(leftTextLabel)
        stack.addArrangedSubview(middleTextLabel)
        stack.addArrangedSubview(rightTextLabel)
        self.contentView.addSubview(stack)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        stack.frame = self.contentView.bounds
    }
}

private let IngredientCellIdentifier = "IngredientCellIdentifier"

private class IngredientsListViewController: UITableViewController {
    var ingredients: [Ingredient]
    var filteredList: [Ingredient]?
    var transformed: [Int]?
    init(list: [Ingredient]) {
        ingredients = list
        super.init(style: .Plain)
        
        self.view.frame = CGRect(x: 0, y: 0, width: 300, height: list.count * 44)
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: IngredientCellIdentifier)
        self.tableView.registerClass(MapCell.self, forCellReuseIdentifier: "MapCell")
        self.tableView.separatorStyle = .SingleLine
        self.tableView.separatorColor = .blueColor()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = transformed == nil ? IngredientCellIdentifier : "MapCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath)

        let ingredient = ingredients[indexPath.row]
        
        if let transforms = transformed {
            let mapCell = cell as! MapCell
            mapCell.leftTextLabel.text = "\(ingredient.quantity)x " + ingredient.name
            let transformedValue = transforms[indexPath.row]
            mapCell.rightTextLabel.text = "$\(transformedValue)"
        } else {
            cell.textLabel!.text = "\(ingredient.quantity)x " + ingredient.name
            cell.accessoryType = ingredient.purchased ? UITableViewCellAccessoryType.Checkmark : UITableViewCellAccessoryType.None
            if filteredList != nil {
                cell.tintColor = UIColor.whiteColor()
            }
            let keep = filteredList?.contains(ingredient) ?? true
            
            cell.textLabel!.textColor = keep ? UIColor.blackColor() : UIColor.whiteColor()
            cell.backgroundColor = keep ? UIColor.whiteColor() : UIColor(red: 126/255.0, green: 72/255.0, blue: 229/255.0, alpha: 1.0)
        }
        return cell
    }
}


public func showIngredients(list: [Ingredient]) -> UIView {
    return IngredientsListViewController(list: list).view
}

public func visualize(list: [Ingredient], _ filteredList: [Ingredient]) -> UIView {
    let list = IngredientsListViewController(list: list)
    list.filteredList = filteredList
    return list.view
}

public func visualize(list: [Ingredient], _ transformed: [Int]) -> UIView {
    let list = IngredientsListViewController(list: list)
    list.transformed = transformed
    return list.view

}


