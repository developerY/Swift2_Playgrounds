/*:
[Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
****
# Indexing and Slicing Strings
It's common to think of a string as a sequence of the characters you see on screen. However, what you perceive as a character may in some cases be represented by multiple, variable-length Unicode scalars in memory. For example, it requires more bits to encode a character like the top hat emoji (`🎩`) than a simple character like the letter `A`, and it requires multiple Unicode scalars to represent characters with combining marks, such as é⃝. For more information about Unicode support in Swift, see [Strings and Characters](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/StringsAndCharacters.html#//apple_ref/doc/uid/TP40014097-CH7-ID285) in _The Swift Programming Language_.

In Swift, the `String` type handles these details for you. Each [Character](xcdoc://?url=developer.apple.com/library/etc/redirect/xcode/ios/1048/documentation/Swift/Reference/Swift_Character_Structure/index.html) value in a string represents any user-perceived Unicode character, regardless of the character's length or representation in memory. However, because of this abstraction, it doesn't make sense to index into a string using integers. Instead, the standard library includes [String.Index](xcdoc://?url=developer.apple.com/library/etc/redirect/xcode/ios/1048/documentation/Swift/Reference/Swift_CharacterView-Index_Structure/index.html), a type that better represents a position in any string, regardless of its representation in memory.

Take a look at the string below, which contains various Unicode characters of different sizes and complexity.
*/
var str = "Héllo, 🇺🇸laygr😮und!"
/*:
Here's what it looks like when you plot the string's characters against their user-perceived indexes. Notice that even though the flag (🇺🇸) is actually a grapheme cluster made up of two combining Unicode scalars, Swift counts the flag as just one user-perceived character. This makes tasks like form validation, cursor positioning, and text wrapping much simpler to implement. Counting, indexing, and slicing are all based on user-perceived character indexes, rather than the layout of the string in memory.
*/
visualize(str)

/*:
  > **Experiment:**
  > Try changing the `str` variable and see how the string visualizations in the playground change. You can add special characters by placing your cursor inside the string and going to Edit > Emoji & Symbols in the menu bar. 
  >
  > When you're done, you can copy and paste the original string back into the variable: `"Héllo, 🇺🇸laygr😮und!"`

Take a look at the string counts in the code below. The `characters` property contains a collection of the Unicode characters in the string, while the `utf16` property contains a collection of the UTF-16 code points. If you compare the number of user-perceived characters with the number of UTF-16 code points in the string, you'll find that the number of UTF-16 code points is higher than the number of Unicode characters.
*/
str.characters.count
str.utf16.count

/*:
Let's create a `Range` value that you can use to index and slice the string. At first glance, you might attempt to create a range from integers. If you option-click the `badRange` constant below, you'll notice that this line of code creates a value of type `Range<Int>`. This isn't exactly right–you usually want to slice the string on user-perceived characters. If you uncomment the line of code after, you'll see this error: _'subscript' is unavailable: cannot subscript String with a range of Int_.
*/
let badRange = 4...12
//str[badRange] // uncomment this line to see error
/*:
Instead, you can use specialized `String.Index` objects to index and slice strings. Every string has a `startIndex` and an `endIndex`, and you can call the `successor()` and `predecessor()` methods on the indexes to increment or decrement them, respectively. You can also use the `advancedBy` method to offset an index–the integer you pass in is used to determine how many times to invoke `successor` or `predecessor`. The `String.Index` type is Unicode-aware, so the `advancedBy` method will always advance a string index correctly. The `advancedBy` method takes into account any large or complex Unicode characters to make sure your range starts, advances, and ends on a complete, user-perceived character.

  > **Note:**
  > The `endIndex` of a string or a range is always one past the end. This makes it easier to check if it's empty: if the `startIndex` and the `endIndex` are equal, then there are no elements. It also makes it easier to check where you are: If your current index is equal to the `endIndex`, then you have reached the end. Therefore, it is a runtime error to call `str[endIndex]` because you are asking for a character at an index past the end of the string.

Try option-clicking the `range` constant. The `advancedBy` method returns a value with the same type as the original index, so the `...` range operator produces a range of that type.
*/
let range = str.startIndex.advancedBy(4)...str.startIndex.advancedBy(12)
/*:
Because the `advancedBy` method offsets any index by a specified integer amount, you can use the `advancedBy` method to retrieve a character at a certain index in a string.
*/
str[str.startIndex.advancedBy(7)]
visualize(str, index: str.startIndex.advancedBy(7))

/*:
Now that you have a range of `String.Index` values, you can use the indexing subscript operator on the start or endpoint of a range as well. By using `String.Index` values as the start and endpoint of the range, you're guaranteed to retrieve a fully-formed character–whether it's a simple ASCII character at the `startIndex` or an emoji character at the `endIndex`.
*/
str[range.startIndex]
visualize(str, index: range.startIndex)
str[range.endIndex]
visualize(str, index: range.endIndex)

/*:
Putting it all together, you can use the `range` variable we created above to retrieve a slice of the string. Notice that the last character in the returned slice is not the same as the character returned when you retrieved the character at the `endIndex` above. Recall that the `endIndex` is always one past the end. Algorithms that operate on indexes take that information into account.

  > **Experiment:**
  > Try changing the `range` variable to start and end on different offsets from the `startIndex` of the string.
*/
str[range]
visualize(str, range: range)
/*:
## Applying Concepts
Using the patterns you learned on this page, let's build a group chat application that promotes quick messaging by limiting message length to 30 characters. 

The app needs to indicate when a user's message is over the character limit. In the code below, the closure passed to the `showChatView` function uses a special version of the `advancedBy` method that takes an end index limit in addition to the start index and offset as you've already seen previously. This version of the `advancedBy` method increments the `startIndex` up to the `endIndex` without overrunning the end. If the string is less than 30 characters long (the value of `messageLimit`), the `advancedBy` method won't increment past the end of the string. If it's over 30 characters, the method returns a range starting at the message limit and extending to the end of the message. The app takes the range returned by the method and highlights that range in red.
*/
let messageCharacterLimit = 30
showChatView { (contents: String) -> Range<String.Index>? in
    let range = contents.startIndex.advancedBy(messageCharacterLimit, limit: contents.endIndex)..<contents.endIndex
    return !range.isEmpty ? range : nil
}

/*:
  > **Experiment:**
  > Try changing the `messageCharacterLimit` variable. Notice how messages that are less than the character limit are handled properly by the `advancedBy` method.
*/
/*:
  > **Checkpoint:**
  > At this point, you've read about the `String` type's Unicode character handling and learned how to index into and slice strings. On the next page, you'll learn how to customize the way your types are printed and displayed.

[Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
*/
