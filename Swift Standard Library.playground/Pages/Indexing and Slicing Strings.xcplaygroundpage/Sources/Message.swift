import Foundation

public struct Message {
    public let from: String
    public let contents: String
    public let date: NSDate
    
    public init(from: String, contents: String, date: NSDate) {
        self.from = from
        self.contents = contents
        self.date = date
    }
}

extension Message: CustomDebugStringConvertible {
    public var debugDescription: String {
        return "[\(date) From: \(from)] \(contents)"
    }
}

private var dateFormatter: NSDateFormatter = {
    let formatter = NSDateFormatter()
    formatter.doesRelativeDateFormatting = true
    formatter.dateStyle = .ShortStyle
    formatter.timeStyle = .ShortStyle
    
    return formatter
}()

extension Message: CustomStringConvertible {
    public var description: String {
        return "\(contents)\n   \(from) \(dateFormatter.stringFromDate(date))"
    }
}

public var messages: [Message] = [
    Message(from: "Sandy", contents: "Hey, what's going on tonight?", date: messageDates[0]),
    Message(from: "Michelle", contents: "Studying for Friday's exam. You guys aren't?", date: messageDates[1]),
    Message(from: "Christian", contents: "Nope. That's what tomorrow is for. Let's get food, I'm hungry!", date: messageDates[2]),
    Message(from: "Michelle", contents: "Maybe. What do you want to eat?", date: messageDates[3])
]
