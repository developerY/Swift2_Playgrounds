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

public var messages: [Message] = []