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

/**
 * ================================
 * ======= Type Annotations =======
 * ================================
 * You can provide a type annotation when you declare a constant or variable,
 * to be clear about the kind of values the constant or variable can store.
 * Write a type annotation by placing a colon after the constant or variable name, followed by a space, followed by the name of the type to use
 *
 **/
var welcome: String

// You can define multiple related variables of the same type
var red, blue, green: Double

/**
* ================================
* ======= Naming variables =======
* ================================
* Variables names can contain almost any character, including Unicode characters.
* They cannot contain whitespaces, mathematical symbols, arrows, private-use Unicode code points, or line- and box-drawing characters or beginning with a number.
* You can't redeclare a variable again with the same name or change its value to a different type. Nor you can change a variable in a constant and viceversa.
**/
// Some examples of variable's names
let π = 3.14159
let 你好 = "你好世界"
let 🐶🐮 = "dogcow"

/**
* ==================================
* ======= Printing Variables =======
* ==================================
* You can print the current value of a constant or variable with the print function
* The definition of the print function is:
* print(_:separator:terminator)
*
* You can omit the separator and terminator most of the time.
**/
let myMessage = "My message"
print(myMessage)

/**
* ==================================
* ======= Semicolons =======
* ==================================
* Unlike many other languages, Swift does not require you to write a semicolon (;) after
* each statement in your code (you can do it if you wish)
* However, they are required if you want to write multiple separate statements on a single line
**/
let cat = "🐱"; print(cat)