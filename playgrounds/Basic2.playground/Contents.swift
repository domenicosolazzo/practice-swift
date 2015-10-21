//: Basic about Swift
// Described in this playground
// - Integers

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







