//: Basic about Swift
// Described in this playground
// - Integers
// - Floating-point numbers

/**
 * =================================
 * =========== Integers ============
 * =================================
**/

/**
Integers are whole numbers with no fractional component. They can be signed or unsigned.
Swift provides both formats in 8, 16, 32 and 64 bit.

The name convention uses UInt8 for an 8-bit unsigned integer, Int32 for a signed 32-bit integer and so on.
**/

/**
==== Integer Bounds ====
You can access the minimum and maximum values of each integer type with its min and max properties
**/
// Min value is equal to 0 and type UInt8
let minValue = UInt8.min

// Max value is equal to 255 and type UInt8
let maxValue = UInt8.max

/**
==== Int ====
Swift provides an additional integer type called Int. It has the same size as the current platform's native word size.

- On a 32-bit platform, Int is the same size as Int32
- On a 64-bit platform, Int is the same size as Int64
**/
let intMaxValue = Int.max
print(intMaxValue)

/**
==== UInt ====
Swift also provides an unsigned integer type UInt, which has the same size as the current platform's 
native word size.

- On a 32-bit platform, UInt is the same size as UInt32
- On a 64-bit platform, UInt is the same size as UInt64
**/
let uintMaxValue = UInt.max
print(uintMaxValue)


/**
* ===============================================
* =========== Floating-Point Numbers ============
* ===============================================
**/
/**
Floating-Point numbers are numbers with a fractional component (e.g. 3.14159, 0.1, -273.12)
They can represent a much wider range of values than integer types, and can store numbers that are much larger or smaller than can be store in an Int.

There are two types of Floating-Point Numbers:
- Double represents a 64-bit floating-point numbers
- Float represents a 32-bit floating-point numbers

Double can have a precision of at least 15 decimal digits, whereas the precision of Float can be as little as 6 decimal digits.
**/
let theDouble:Double = 3.252151521522
let theFloat:Float = 3.29

/**
* ====================================
* =========== Type safety ============
* ====================================
**/
/**
Swift is a safe language and it encourages you to be clear about the types of values 
your code can work with. If a variable expects a String, you cannot pass it an Int.

Swift performs type checks when compiling your code and flags any mismatched types as errors.
It helps to catch and fix errors as early as possible in the development process.
**/

/**
* ====================================
* =========== Type inference ============
* ====================================
**/
/**
Swift uses type inference, which helps a compiler to deduce the appropriate type for a variable.
For this reason, Swift requires far fewer type declarations than languages such as C.
Constant and variables are still explicitely typed but the work of specifying their type is done for you.

Swift will infer a Double type for Floating-Point numbers and when combining Integers and Floating-Point literals.ot 
**/
let meaningOfLife = 42 // Swift will infer that the type of the variable is Int
let pi = 3.14159 // Swift will infer that they type of the variable is Double (Floating-Point)

let inferredType = 3 + 0.14159 // Swift will infer Double from the context

/**
* =======================================
* =========== Numeric Literals ==========
* =======================================
**/
/**
Integer literals can be written as:
- A decimal number, with no prefix
- A binary number, with a 0b prefix
- An octal number, with a 0o prefix
- A hexadecimal number, with a 0x prefix

**/
// Decimal value of 17
let decimalInteger = 17
let binaryInteger = 0b10001
let octalInteger = 0o21
let hexadecimalInteger = 0x11




