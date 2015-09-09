/*:
[Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
****
# Understanding Sequence and Collection Protocols
The best way to understand how sequence and collection protocols work in the standard library is to implement your own conforming type. Let's build a daily photo app that allows users to capture the most important moment of every day and view these moments in a timeline. To implement the model layer, we'll create a custom collection type that represents a continuous range of dates and associated images. Here's what the finished app looks like:
*/
import UIKit
let app = finishedApp

/*:
## Model Architecture
When you model your app's storage, it's important to consider the required behaviors and expected performance characteristics. This is true whether you implement your own custom storage or use a combination of standard library data types. For the timeline app, there are three areas to consider:
1. Each date can be associated with an image
2. The timeline displays a continuous, ordered series of days
3. Dates can be incremented arbitrarily and compared in constant time

When you look at the sum of these considerations, the built-in collection types can be ruled out. Dictionaries provide adequate representation for pairs of dates and images and support fast retrieval of values using keys, but are not ordered and cannot contain keys that do not have associated values. On the other hand, arrays are ordered but cannot quickly retrieve values using keys. Additionally, there are application-specific constraints and behaviors that could be modeled at a higher level, but would be simpler to maintain in the storage itself. A collection type that is not generic, but instead understands the qualities of the types it contains may provide considerable benefits.

Let's examine the second and third areas more closely. The timeline displays a _ordered_ series of days. With a collection that has knowledge of the type of the elements, this is trivial to implement–dates have a natural, well defined order. The series is _continuous_ as well–even if a day is not associated with an image, it is still present in the collection and displayed in the timeline. Therefore, in addition to order, the indexes are trivially knowable and can be generated as needed. This means the collection can represent an infinite series of every date–without using an infinite amount of memory. Finally, because dates can be incremented and compared in constant time, indexing by date can be implemented in constant time. Therefore, a collection with a date 100 years in the past and 100 years in the future should be just as performance and memory efficient as a collection containing two consecutive dates.

With this information, the shape of our collection comes into focus: A collection called TimelineCollection with the behaviors and performance characteristics of an array, but with an API that–in some important cases–mirrors that of a dictionary.
## Implementing the Index
Before we implement the collection, let's implement the collection's index type–the type you use to iterate over and subscript into the collection. In our TimelineCollection type, the indexes into the array are dates.

To be used as a collection index, a type must implement basic behavior to support operations like subscripting and for-in style iteration. At a minimum, an index type must adopt the `ForwardIndexType` protocol. Rather than use the `NSDate` class itself as the collection's index type, let's wrap the `NSDate` class in a `DateIndex` type where we can implement additional behavior, starting with this simple structure:
*/
struct DateIndex {
    let date: NSDate
}
/*:
The `NSDate` class doesn't just store the date–it also stores the time down to the millisecond. Recall that the timeline app is designed to capture and display the most important moment in a user's day. The particular time of day isn't important, and every time a user takes a new photo on the same day it should replace the current photo for that day if one exists.

To make it easy to step through and look up images for particular days, the `DateIndex` type needs to normalize the date when one is created. In the extension below, the `DateIndex` structure is extended with a new initializer that uses the `startOfDayForDate` method on the user's current calendar to shift the provided date to the first moment in that date's day. As long as the rest of the collection implementation traffics in `DateIndex` objects rather than directly in `NSDate` objects, we can be sure that the time of day of a date will not impact comparison, iteration, or image lookup.
*/
private let calendar = NSCalendar.currentCalendar()
extension DateIndex {
    init (_ date: NSDate) {
        self.date = calendar.startOfDayForDate(date)
    }
}
/*:
After you write the basic implementation of a type, it's useful to adopt the `CustomDebugStringConvertible` protocol. Whenever you use the type in a playground or as an argument to the `debugPrint` function, the `debugDescription` property is used to print a description of the type. You can read more about custom descriptions in [Customizing Textual Representations](Customizing%20Textual%20Representations).

In the code below, the `DateIndex` structure conforms to `CustomDebugStringConvertible` and returns the stored date as a simple string containing the month and the day.
*/
let dateFormatter = NSDateFormatter()
dateFormatter.dateFormat = NSDateFormatter.dateFormatFromTemplate("MMMM d", options: 0, locale: NSLocale.currentLocale())

extension DateIndex: CustomDebugStringConvertible {
    var debugDescription: String {
        return dateFormatter.stringFromDate(date)
    }
}
/*:
Now that instances of `DateIndex` are normalized and debuggable, the next step is to adopt the `ForwardIndexType` protocol. There are two requirements in the `ForwardIndexType` protocol: computing successive indexes and testing for equality. In addition to syntactically defined requirements, there are also _semantic_ and _performance_ requirements. These are requirements that cannot be expressed in code–but are still equally important. The `ForwardIndexType` protocol documentation contains two such requirements:
1. The successor of an index must be well-defined. In other words, you must consistently return the same successor for a given index.
2. Computing the successor must be a constant-time (`O(1)`) operation. Otherwise, generic collection algorithms would have inconsistent or unexpected performance characteristics.

The following extension on `DateIndex` adopts the `ForwardIndexType` type and implements the `successor` method. The `NSCalendar` class includes an efficient method to increment a date by any value, so the method implementation below simply creates a new date by incrementing index's date by one day and then returns a new `DateIndex` instance with the new date. Because successive dates are consistently producible can be computed in constant time, we have satisfied both additional documented requirements.
*/
extension DateIndex: ForwardIndexType {
    typealias Distance = Int
    func successor() -> DateIndex {
        let nextDay = calendar.dateByAddingUnit(.Day, value: 1, toDate: self.date, options: [])!
        return DateIndex(nextDay)
    }
}
/*:
The `ForwardIndexType` protocol inherits from the `Equatable` protocol. The `NSDate` class already implements the `==` operator (by implementing the `isEqual:` method), so the operator implementation below simply compares the indexes' dates. After implementing this operator, the `DateIndex` structure completely adopts the `ForwardIndexType` protocol.
*/
func == (lhs: DateIndex, rhs: DateIndex) -> Bool {
    return lhs.date == rhs.date
}
extension DateIndex: Equatable { }

/*:
The `TimelineCollection` structure–which we'll implement in the following section–stores `DateIndex` instances as keys in a dictionary. Keys in a dictionary must be hashable, so the code example below extends `DateIndex` to conform to the `Hashable` protocol.
*/
extension DateIndex: Hashable {
    var hashValue: Int {
        return date.hashValue
    }
}
/*:
## Implementing the Collection
To implement a type that conforms to the `CollectionType` protocol, you implement–at a minimum–three requirements of the protocol:
1. A property called `startIndex` that returns the first index in the collection.
2. A property called `endIndex` that returns the index one past the end.
3. A subscript that accepts an index and returns an element in the collection.

From these three requirements, the remaining requirements in the `CollectionType` protocol, such as `generate()`, `isEmpty`, and `count` are implemented for you using default implementations in protocol extensions. For example, the `isEmpty` property has a default implementation expressed terms of the `startIndex` and `endIndex`: if the `startIndex` and `endIndex` are equal, then there are no elements in the collection.

In the code below, we implement the `TimelineCollection` structure and the minimum syntactic, semantic, and performance requirements to act as a collection. The timeline collection implements its underlying storage as a dictionary of `DateIndex`-`UIImage` pairs for performance and efficiency, but provides access to this storage through `DateIndex` APIs to maintain our high level constraints. This achieves performance characteristics and API influenced by both `Array` and `Dictionary`–while maintaining higher level application constraints like order.
*/
struct TimelineCollection: CollectionType {
    
    private var storage: [DateIndex: UIImage] = [:]
    
    var startIndex = DateIndex(NSDate.distantPast()) // Placeholder date
    var endIndex = DateIndex(NSDate.distantPast())   // Placeholder date
    
    subscript (i: DateIndex) -> UIImage? {
        get {
            return storage[i]
        }
        set {
            storage[i] = newValue
            
            // The `TimelineCollection` expands dynamically to include the earliest and latest dates.
            // To implement this functionality, any time a new date-image pair is stored using this
            // subscript, we check to see if the date is before the `startIndex` or after the `endIndex`.
            // Additionally, if the `startIndex` is one of the placeholder dates, we adjust the `startIndex`
            // upwards to the passed-in date.
            if startIndex == DateIndex(NSDate.distantPast()) || i.date.compare(startIndex.date) == .OrderedAscending {
                startIndex = i
            }
            
            let endIndexComparison = i.date.compare(endIndex.date)
            if endIndexComparison == .OrderedDescending || endIndexComparison == .OrderedSame {
                // The `endIndex` is always one past the end so that iteration and `count` know when
                // to stop, so compute the successor before storing the new `endIndex`.
                endIndex = i.successor()
            }
        }
    }
}
/*:
We'll also implement a subscript and range operators that take `NSDate` objects and wrap them up as `DateIndex` instances. While the collection uses normalized `DateIndex` objects in its implementation, it surfaces those implementation details as little as possible as they are not semantically important.
*/
extension TimelineCollection {
    subscript (date: NSDate) -> UIImage? {
        get {
            return self[DateIndex(date)]
        }
        set {
            self[DateIndex(date)] = newValue
        }
    }
}

func ... (lhs: NSDate, rhs: NSDate) -> Range<DateIndex> {
    return DateIndex(lhs)...DateIndex(rhs)
}

func ..< (lhs: NSDate, rhs: NSDate) -> Range<DateIndex> {
    return DateIndex(lhs)..<DateIndex(rhs)
}
/*:
At this point, we've implemented everything that's required for the `TimelineCollection` to conform to the `CollectionType` protocol. The Swift standard library includes default implementations that use the methods and properties we've defined so far to implement the remaining `CollectionType` requirements like `count`, `map`, `reverse`, and efficient slicing. Let's take a look at the timeline collection in action:
*/
var timeline = TimelineCollection()
timeline.count

for elem in loadElements() {
    timeline[elem.date] = elem.image
}

maySeventh
let image = timeline[maySeventh]

let view = UIView(frame: CGRect(x: 0, y: 0, width: timeline.count * 75, height: 75))
for (position, image) in timeline.enumerate() {
    let imageView = UIImageView(frame: CGRect(x: position * 75, y: 0, width: 75, height: 75))
    imageView.image = image ?? UIImage(named: "NoImage.jpg")
    view.addSubview(imageView)
}
view

/*:
## Refining the Index
The timeline collection sufficiently implements the syntactic, semantic, and performance requirements of the `CollectionType` protocol. However, we've missed out on some easy performance enhancements and additional functionality. By continually refining the `DateIndex` structure, we can drastically improve performance and opt in to additional functionality.

The first of these refinements is the `BidirectionalIndexType` protocol. The `BidirectionalIndexType` protocol inherits from the `ForwardIndexType` protocol and adds one method, `predecessor()`. The `predecessor` method mirrors the `successor` method–including the semantic and performance requirements–and decrements the index by one. Using the same constant time `NSCalendar` method, the extension below adopts `BidirectionalIndexType` and implements the `predecessor` method.

By adopting the `BidirectionalIndexType` protocol, the timeline collection gains access to the default implementation of `reverse()`, which provides an efficient reverse view into the collection.
*/
extension DateIndex: BidirectionalIndexType {
    func predecessor() -> DateIndex {
        let previousDay = calendar.dateByAddingUnit(.Day, value: -1, toDate: date, options: [])!
        return DateIndex(previousDay)
    }
}
/*:
The current default implementation for `count` that is applied to the timeline collection retrieves the `startIndex` and then counts how many times `successor()` must be invoked on the index to reach the `endIndex` of the collection. This is a reasonable `O(n)` implementation, but offers poor performance in the case where dates with images are spread far apart. It's also a problem that's easily resolved with a constant time implementation because dates are used as indexes.

The `RandomAccessIndexType` protocol can be adopted by index types that are able to compute the distance between two indexes and advance multiple positions in constant time. For example, the `Array` structure's index type is `Int`. `Int` conforms to `RandomAccessIndexType` because you can add an offset to a position represented by an integer in constant time. When you adopt the `RandomAccessIndexType` protocol, a more specific, faster default implementation for collection APIs like `count` is used instead.

To adopt the `RandomAccessIndexType`, the code below implements its two requirements in terms of `NSCalendar` methods that compute and compare dates.
*/
extension DateIndex: RandomAccessIndexType {
    func distanceTo(other: DateIndex) -> Int {
        return calendar.components(.Day, fromDate: self.date, toDate: other.date, options: []).day
    }
    
    func advancedBy(n: Int) -> DateIndex {
        let advancedDate = calendar.dateByAddingUnit(.Day, value: n, toDate: self.date, options: [])!
        return DateIndex(advancedDate)
    }
}

let fastCount = timeline.count

/*:
Here is the completed photo memory app:
*/
visualize(timeline)

/*:
  > **Checkpoint:**
  > At this point you've processed and sliced collections using generic algorithms, and you've learned how standard library protocols combine to define collections and sequences. The concepts you've learned on this page apply whether or not you plan to implement your own custom collection type. By understanding how the standard library divides functionality into small protocols that work together to define many different types, you can write generic code that is flexible and expressive. More generally, the design patterns used by the standard library apply to your own code–consider reaching first for protocols and structures to improve how you reason about your code.

[Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
*/
