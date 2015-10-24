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


/**
Decimal floats can have an optional exponent, indicated by an uppercase or lowercase "e";
hexadecimal floats must have an exponent, indicated by an uppercase "p"

For dcimal numbers with an exponent of exp, the base number is multiplied by 10^exp
**/
let exp1 = 1.25e2    // 1.25 * 10^2  => 125.0
let exp2 = 1.25e-2   // 1.25 * 10^-2 => 0.0125
let exp3 = 0xFp2     // 15 * 2^2 => 60.0
let exp4 = 0xFp-2    // 15 * 2^-2 => 3.75


/**
* =======================================
* =========== Booleans ==================
* =======================================
**/
/**
Swift has a boolean type, called Bool.
Boolean has two constant values, true and false
**/
let orangesAreOrange = true
let applesAreOrange = false


/**
* =======================================
* =========== Type Aliases ==============
* =======================================
**/
/**
Type aliases define an alternative name for an existing type.
You define type aliases with the typealias keyword.

Type aliases are useful when you want to refer to an existing
type by a name that is contextually more appropriate, such as
when working with data of a specific size.
**/
typealias AudioSample = UInt16

var maxAmplitudeFound = AudioSample.min

/**
* =======================================
* =========== Tuples ====================
* =======================================
**/
/**
Tuples group multiple values into a single compound value.
The values within a tuple can be of any type and do not have
to be of the same type as each other.
**/
let tupleExample = (404, "Not Found") // Tuple of type (Int, String)

/**
You can decompose a tuple's contents into a separate constants or variables,
which you then access as usual
**/
let (statusCode, statusMessage) = tupleExample

print("Status code is \(statusCode)")
print("Status message is \(statusMessage)")

/**
If you only need some of the tuple's values, ignore parts of the tuple with an underscore (_)
when you decompose the tuple
**/
let (justTheStatusCode, _) = tupleExample

/**
Alternatively, access to the individual element values in a tuple using index numbers starting at zero
**/
print("The status code is \(tupleExample.0)")

/**
* =======================================
* =========== Assertions ================
* =======================================
**/
/**
In some cases, it is not possible for your code to continue execution 
if a particular condition is not satisfied.
In these situations, you can trigger an assertion in your code to end code
execution and to provide an opportunity to debug.
Assertion will cause your code to stop!
**/
/** 
let age = -3
assert(age >= 0, "A person's age cannot be less than zero")
// The assert will trigger and print the message if the assertion is false
**/