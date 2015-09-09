import UIKit

private let calendar = NSCalendar.currentCalendar()

private var dateFormatter: NSDateFormatter?

private struct DateIndex: CustomDebugStringConvertible, Hashable, RandomAccessIndexType {
    typealias Distance = Int
    let date: NSDate
    
    init (_ date: NSDate) {
        self.date = calendar.startOfDayForDate(date)
    }
    
    var debugDescription: String {
        if dateFormatter == nil {
            dateFormatter = NSDateFormatter()
            dateFormatter!.dateFormat = "MMMM d"
        }
        return dateFormatter!.stringFromDate(date)
    }
    
    var hashValue: Int {
        return date.hashValue
    }
    
    func successor() -> DateIndex {
        let nextDay = calendar.dateByAddingUnit(.Day, value: 1, toDate: date, options: [])!
        return DateIndex(nextDay)
    }
    
    func predecessor() -> DateIndex {
        let previousDay = calendar.dateByAddingUnit(.Day, value: -1, toDate: date, options: [])!
        return DateIndex(previousDay)
    }
    
    func distanceTo(other: DateIndex) -> Int {
        return calendar.components(.Day, fromDate: self.date, toDate: other.date, options: []).day
    }
    
    func advancedBy(n: Int) -> DateIndex {
        let advancedDate = calendar.dateByAddingUnit(.Day, value: n, toDate: self.date, options: [])!
        return DateIndex(advancedDate)
    }
}

private func == (lhs: DateIndex, rhs: DateIndex) -> Bool {
    return lhs.date == rhs.date
}
extension DateIndex: Equatable { }

private struct DateCollection: CollectionType {
    
    private var storage: [DateIndex: UIImage] = [:]
    
    var startIndex = DateIndex(NSDate.distantPast())
    var endIndex = DateIndex(NSDate.distantPast())
    
    subscript (i: DateIndex) -> UIImage? {
        get {
            return storage[i]
        }
        set {
            storage[i] = newValue
            if startIndex == DateIndex(NSDate.distantPast()) || i.date.compare(startIndex.date) == .OrderedAscending {
                startIndex = i
            }
            if i.date.compare(endIndex.date) == .OrderedDescending {
                endIndex = i.successor()
            }
        }
    }
    
    subscript (date: NSDate) -> UIImage? {
        get {
            return self[DateIndex(date)]
        }
        set {
            self[DateIndex(date)] = newValue
        }
    }
}

public var finishedApp: UIView = {
    var dates = DateCollection()
    for elem in loadElements() {
        dates[elem.date] = elem.image
    }
    
    return visualize(dates)
}()



