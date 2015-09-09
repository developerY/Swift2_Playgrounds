import UIKit

public var pastAllowedLengthFunction: ((String) -> Range<String.Index>?)?

private let messageCellIdentifier = "MessageCell"

private class GroupChatController: UITableViewController {
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewStyle) {
        super.init(style: style)
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: messageCellIdentifier)
        view.frame = CGRect(x: 0, y: 0, width: 320, height: 300)
        tableView.separatorStyle = .SingleLine
        tableView.separatorColor = .blueColor() // FIXME: not working
        tableView.estimatedRowHeight = 60
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(messageCellIdentifier, forIndexPath: indexPath)
        
        let attributedString = NSMutableAttributedString(string: String(messages[indexPath.row]))
        if let redRangeFunction = pastAllowedLengthFunction, let redRange = redRangeFunction(messages[indexPath.row].contents) {
            let redAttribute: [String: AnyObject] = [
                NSBackgroundColorAttributeName: UIColor.redColor()
            ]
            
            let location = messages[indexPath.row].contents.startIndex.distanceTo(redRange.startIndex)
            let length = redRange.startIndex.distanceTo(redRange.endIndex)
            attributedString.setAttributes(redAttribute, range: NSRange(location: location, length: length))
        }
        
        cell.textLabel!.numberOfLines = 0
        cell.textLabel!.attributedText = attributedString
        return cell
    }
}



private let chatController = GroupChatController(style: .Plain)
private var chatView: UIView {
    return chatController.view
}

public func showChatView(rangeFunc: (contents: String) -> Range<String.Index>?) -> UIView {
    pastAllowedLengthFunction = rangeFunc
    return chatView
}
