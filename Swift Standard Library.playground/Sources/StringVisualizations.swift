import UIKit

private enum Theme {
    enum Color {
        static let border = UIColor(red: 184/255.0, green: 201/255.0, blue: 238/255.0, alpha: 1)
        static let shade = UIColor(red: 227/255.0, green: 234/255.0, blue: 249/255.0, alpha: 1)
        static let highlight = UIColor(red: 14/255.0, green: 114/255.0, blue: 199/255.0, alpha: 1)
    }
    enum Font {
        static let codeVoice = UIFont(name: "Menlo-Regular", size: 14)!
    }
}

private struct StyledString {
    let string: String
    let shaded: Bool
    let highlighted: Bool
    let bordered: Bool
}

private extension UILabel {
    convenience init(styledString: StyledString) {
        self.init()
        text = styledString.string
        textAlignment = .Center
        font = Theme.Font.codeVoice
        textColor = styledString.highlighted ? Theme.Color.highlight : UIColor.blackColor()
        backgroundColor = styledString.shaded ? Theme.Color.shade : UIColor.whiteColor()
        if (styledString.bordered) {
            layer.borderColor = Theme.Color.border.CGColor
            layer.borderWidth = 1.0
        }
    }
}

public func visualize(str: String) -> UIView {
    return _visualize(str, range: nil)
}

public func visualize(str: String, index: String.Index) -> UIView {
    return _visualize(str, range: index...index)
}

public func visualize(str: String, range: Range<String.Index>) -> UIView {
    return _visualize(str, range: range)
}

private func _visualize(str: String, range: Range<String.Index>?) -> UIView {
    let stringIndices = str.characters.indices
    
    let styledCharacters = zip(stringIndices, str.characters).map { (characterIndex, char) -> StyledString in
        let shaded: Bool
        if let range = range where range.contains(characterIndex) {
            shaded = true
        } else {
            shaded = false
        }
        return StyledString(string: String(char), shaded: shaded, highlighted: false, bordered: true)
    }
    
    let characterLabels = styledCharacters.map { UILabel(styledString: $0) }
    
    let styledIndexes = (0..<stringIndices.count).map { index -> StyledString in
        let characterIndex = str.startIndex.advancedBy(index)
        
        let highlighted: Bool
        if let range = range where range.startIndex == characterIndex || range.last == characterIndex {
            highlighted = true
        } else {
            highlighted = false
        }
        
        return StyledString(string: String(index), shaded: false, highlighted: highlighted, bordered: false)
    }
    
    let indexLabels = styledIndexes.map { UILabel(styledString: $0) }
    
    let charStacks: [UIStackView] = zip(characterLabels, indexLabels).map { (charLabel, indexLabel) in
        let stack = UIStackView()
        stack.axis = .Vertical
        stack.distribution = .FillEqually
        stack.addArrangedSubview(indexLabel)
        stack.addArrangedSubview(charLabel)
        return stack
    }
    
    let stackView = UIStackView(frame: CGRect(x: 0, y: 0, width: 25 * charStacks.count, height: 50))
    stackView.distribution = .FillEqually
    charStacks.forEach(stackView.addArrangedSubview)
    
    return stackView
}

public let messageDates = [
    NSDate().dateByAddingTimeInterval(-2000),
    NSDate().dateByAddingTimeInterval(-1500),
    NSDate().dateByAddingTimeInterval(-500),
    NSDate()
]


