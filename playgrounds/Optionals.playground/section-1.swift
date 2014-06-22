// Optionals: Use optionals when a value may be absent
import Cocoa

let possibleNumber = "123"
// This is converted to Int? (Optional int) because not every string can be
// converted to Int
let number = possibleNumber.toInt()

/*
====== IF statements ======
*/
if number{
    // If the optional contains a value, the if statement will be true
    println("The number exists")
}else{
    println("The number does not exist")
}

/*
====== Forced unwrapping ======
*/
// You use the exlamation mark when you know that the optional has a value
// If the optional does not contain any value, it will throw a runtime-error
var unwrappedNumber = number!

/*
====== Nil ======
*/
var optional: String? = nil // Set the optional to a valueless state

/*
====== Implicit Unwrapped Options ======
*/
// Used when a optional will always have a value (e.g. class initialization)
// If you access an implicit unwrapped option without value, a runtime-error will be thrown
var implicitOptional: String!

