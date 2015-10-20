//: Basic about Swift
// Swift is the new programming language for iOS, OS X and watchOS

/**
 * Swift provides all fundamental C and Objective-C types like Int for Integers,
 * Double and Float for floating-point values, Bool for Boolean values, and
 * String for textual data.
 **/
var myInt: Int = 3
var myDouble: Double = 2.12
var myFloat: Float = 2.0
var myBool: Bool = true
var myString: String = "My string"

/**
 * Swift use variables and constants for storing value and referring to them by name
 * It uses the 'var' keyword followed from a name to define a variable.
 * It uses the 'let' keyword followed from a name to define a constant.
 * A constant value cannot be changed after it has been defined.
**/
var myVariable = "This is a variable containing a String"
myVariable = "Changing this variable"

let myConstant = "This is a constant and you cannot change this value"
// myConstant = "error" <= It would give an error

/**
 * You can declare multiple constants or multiple variables on a single line, separated by commas
 **/
var x = 0.0, y = 0.0, z = 0.0
