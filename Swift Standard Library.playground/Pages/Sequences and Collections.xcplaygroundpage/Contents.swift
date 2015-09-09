/*:
[Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
****
# Sequences and Collections
The Swift standard library is built on many small protocols that define the behavior and interface required of conforming types. These protocols combine in ways that express powerful abstractions. In addition to specifying requirements, many of these protocols have extensions that implement some of these requirements as well as other functionality that conforming types can take advantage of. 

For example, because collections like [Array](xcdoc://?url=developer.apple.com/library/etc/redirect/xcode/ios/1048/documentation/Swift/Reference/Swift_Array_Structure/index.html), [Dictionary](xcdoc://?url=developer.apple.com/library/etc/redirect/xcode/ios/1048/documentation/Swift/Reference/Swift_Dictionary_Structure/index.html), and [Set](xcdoc://?url=developer.apple.com/library/etc/redirect/xcode/ios/1048/documentation/Swift/Reference/Swift_Set_Structure/index.html) share some functionality, they adopt a set of related protocols. Some of these protocols, such as [SequenceType](xcdoc://?url=developer.apple.com/library/etc/redirect/xcode/ios/1048/documentation/Swift/Reference/Swift_SequenceType_Protocol/index.html) and [CollectionType](xcdoc://?url=developer.apple.com/library/etc/redirect/xcode/ios/1048/documentation/Swift/Reference/Swift_CollectionType_Protocol/index.html), define indexing and iteration, making it is simple to write generic code that precisely expresses the functionality required to complete a task.

In this chapter, you will learn how to consume and manipulate various collection types. Then you'll use standard library protocols to build your own collection type, and use it to implement features in a photo timeline app.

****
[Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
*/
