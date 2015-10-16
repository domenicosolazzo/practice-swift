// Try / Catch: New feature in Swift 2

import UIKit

var str = "Hello, Try / Catch"

// Adding an enumeration with the Errors
enum MyError: ErrorType {
    case UserError
    case NetworkError
    case DiscoveryError
}
// Adding a fake function
// Throws is a simple keyword that you add to your method to tell Swift it might fail
func doStuff() throws -> String{
    print("Do stuff1")
    print("Do stuff2")
    
    throw MyError.NetworkError
    
    return "Some return value"
}

// Do / Catch statement
do {
    try doStuff() // Acknowledge that this code may fail
    print("Success")
}catch{
    print("An error occurred")
}

do {
    try doStuff()
    print("Success")
} catch MyError.NetworkError {
    print("A newtwork error occurred")
} catch {
    print("An error occurred")
}


// Error in Swift 1.2
var err:NSError?
let contents = NSString(contentsOfFile: filePath, encoding: NSUTF8StringEncoding, error: &err)
if err != nil{
    //Do something crazy!
}
