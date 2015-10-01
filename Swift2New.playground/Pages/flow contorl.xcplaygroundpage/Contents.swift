//: [Previous](@previous)

import Foundation

var str = "Hello, playground"


//: ## repeat-while
//: **The do keyword is replaced by repeat in the do-while context:**

var i = 0
func MyRepeat() {
    repeat {
        print("Hello World!")
        i++
        
    } while i < 4
}

var i = 0
repeat {
    i++
    print(i)
} while i < 10


//: *do is now used to set scope*

do {
    let ash = "my1name"
}

do {
    let ash = "my2name"
}
let ash = "name"
//let ash = "myName"


//: ## check avaliablility 
//: Every developer knows the struggle when building an app that supports multiple iOS versions. You always want to use the latest version of APIs, but sometimes this may cause errors when the app is run on older versions of iOS. Prior to Swift 2, there is no standard way to do availability check. As an example, the NSURLQueryItem class was only available since the release of iOS 8. If you use the class on older versions of iOS, you’ll end up with an error and probably causes an app crash. To prevent the error, you may perform the availability checking like this:

if NSClassFromString("NSURLQueryItem") != nil {
    // iOS 8 or up
} else{
    // Older iOS versions
}

//:This is one way to check if the class exists. Starting with Swift 2, it finally comes with built-in support for checking API availability. You can easily define an availability condition so that the block of code will only be executed on certain iOS versions. Here is an example:

if #available(iOS 8, *) {
    // iOS 8 or up
    let queryItem = NSURLQueryItem()
    
} else {
    // Earlier iOS versions
    
}

//: [Next](@next)
