//: [Previous](@previous)

import UIKit

var str = "Hello, playground"

//: # Error Handling
//: ### Error handling. Now you can create routines that throw, catch, and manage errors in Swift. You can surface and deal with recoverable errors, such as “file-not-found” or network timeouts. Swift 2.0 error handling interoperates transparently with NSError.

//: *old way*
//: var err: NSError?
//:
//: let contents = NSString(contentsOfFile: filePath, encoding: NSUTF8StringEncoding, error: &err)
//:
//: if err != nil {
//:   uh-oh!
//: }


//:## Do Try

// emum error type
enum MyError: ErrorType {
    case UserError
    case NetworkError
    case DiscoverydError
}

// throws
func doStuff() throws -> String {
    //throw MyError.NetworkError
    throw MyError.UserError
    return "Some return value"
}


func doTryMe() {
    do {
        try doStuff()
        print("Success")
    } catch MyError.NetworkError {
        print("A network error occurred")
    } catch {
        print("An error occurred")
    }
}



//: ## Guard
//: #### Using if-let often you need to do a lot of work within the scope of the braces that follow the statement or pass a value back to another optional. With guard you deal with the else statement first for what happens if the statement fails, after which you have access to the value(s) in non-optional form.
//: *A Guard Statement MUST Transfer Control*


func submitTapped() {
    
    //let userName : String? = nil
    let userName : String? = "userAshrafiName"
    
    guard let unwrappedName = userName else {
        return
    }
    
    // user name can not be nil if we get here
    guard userName!.characters.count > 0 else {
        return
    }
    print("All good")
    
    
    
    // must be good
    print("Your username is \(unwrappedName)")
    
    
    
}

//submitTapped()

//: Engine Gaurd test

enum CarEngineErrors: ErrorType {
    case NoFuel
    case OilLeak
    case LowBattery
}

let fuelReserve = 0.0
let oilOk = true
let batteryReserve = 0.0

func checkEngine() throws {
    guard fuelReserve > 0.0 else {
        throw CarEngineErrors.NoFuel
    }
    
    guard oilOk else {
        throw CarEngineErrors.OilLeak
    }
    
    guard batteryReserve > 0.0 else {
        throw CarEngineErrors.LowBattery
    }
}


func startEngine() {
    do {
        try checkEngine()
        print("Engine started")
    } catch CarEngineErrors.NoFuel {
        print("No Fuel!")
    } catch CarEngineErrors.OilLeak {
        print("Oil Leak!")
    } catch CarEngineErrors.LowBattery {
        print("Low Battery!")
    } catch {
        // Default
        print("Unknown reason!")
    }
}

//startEngine()

//: ### Paramid of dome
/*:
[discussion of paramid of doom](http://stackoverflow.com/questions/29364886/is-there-a-better-way-of-coping-with-swifts-nested-if-let-pyramid-of-doom)
*/
/*:
[Wiki of Pyramid of doom](https://en.wikipedia.org/wiki/Pyramid_of_doom_(programming))
*/


var users: String? = "one"
var first: String? = "two"
var look: String? = "three"


func crashMe() {
    let badnum = look!.characters.count + 2;
                print(" CRASH \(badnum) - \(first) - \(look)")
}

func unWrapMe() {
    if let aUnwrapped = users {
        if let bUnwrapped = first {
            if let cUnwrapped = look {
                print("All unwrapped \(aUnwrapped) - \(bUnwrapped) - \(cUnwrapped)")
                crashMe()
            }
        }
    }
}

func unWrapMeIf() {
    if let aUnwrapped = users,
        bUnwrapped = first,
        cUnwrapped = look {
            print("All unwrapped \(aUnwrapped) - \(bUnwrapped) - \(cUnwrapped)")
            crashMe()
    }
}


func unWrapMeGuardLet() {
    guard let aUnwrapper =  users,
        bUnwrapper = first,
        cUnwrapper = look else {
            return
    }
    
    print("All unwrapped \(aUnwrapper) - \(bUnwrapper) - \(cUnwrapper)")
    crashMe()
    
}


//users?.characters.count // user is optional
func unWrapMeGuard() {
    //Guard is TRUE keep going
    guard (users != nil && first != nil &&  look != nil) else {
        return
    }
    print("All unwrapped \(users) - \(first) - \(look)")
    crashMe()
}




//crashMe()
//unWrapMe()
//unWrapMeIf()
//unWrapMeGuard()
unWrapMeGuardLet()


//: Optional Chaining


class Person {
    var myAddress = Address?()
}

class Address {
    var buildingName = Building?()
}

class Building {
    var name: String?
}

let john = Person()
func initPerson() {
    john.myAddress = Address()
    john.myAddress?.buildingName = Building()
    john.myAddress?.buildingName?.name = "home"
}

func crashPerson() {
    let johnBuilding = john.myAddress?.buildingName?.name?.characters.count 
    let jbc = johnBuilding! + 1
    print(jbc)
    
}

func runPerson() {
    initPerson()
    let johnBuilding = john.myAddress?.buildingName?.name?.characters.count
    let jbc = johnBuilding! + 1
    print(jbc)

}

func ifPerson() {
    if let johnBuilding = john.myAddress?.buildingName?.name?.characters.count {
        let jbc = johnBuilding + 1
        print(jbc)
    } else {
        print("safe")
    }
    
}

func guardPerson() {
    initPerson()
    guard let  ja = john.myAddress?.buildingName?.name?.characters.count else {
        print("safe")
        return // must return
    }
    
    print(ja + 1)
    
}


//crashPerson()
//runPerson()
//ifPerson()
//guardPerson()


//: ## defere
//: #### The defer keyword enables us to do something when code within the current scope completes.

enum simpError: ErrorType {
    case UserError
    case NetworkError
    case DiscoverydError
}

func deferStuff() throws -> String {
    defer {
        print("Do [defer] clean up here")
    }
    
    print("Do stuff start")
    print("Do stuff before error")
    //throw MyError.NetworkError
    throw MyError.UserError
    
    print("Do stuff after error")
    
    return "Some return value"
}


func didLoad() {
    
    print("did Load Checkpoint 1")
    do {
        try doStuff() // defer
        print("Checkpoint 2")
    } catch {
        print("catch error")
    }
    print("Checkpoint 3")
}




//didLoad()


//: [Next](@next)
