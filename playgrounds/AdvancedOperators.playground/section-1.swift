// Playground: Advanced operators
import Cocoa

/**
====== Bitwise Operators ======

Bitwise operators enable you to manipulate the individual raw data bits withing a data structure
*/

/*
=== Bitwise NOT operator (~) ===
*/
let initialBits: UInt8 = 0b00001111
let invertedBits = ~initialBits // 11110000

/*
=== Bitwise AND operator (&) ===
*/
let firstSixBits: UInt8 = 0b11111100
let lastSixBits:UInt8 = 0b00111111
let middleFourBits = firstSixBits & lastSixBits // 00111100

/*
=== Bitwise OR operator (|) ===
*/
let someBits: UInt8 = 0b10110010
let moreBits: UInt8 = 0b01011110
let combinedbits = someBits | moreBits // 11111110

/*
=== Bitwise XOR operator (^) ===
*/
let firstBits:UInt8 = 0b00010100
let otherBits: UInt8 = 0b00000101
let outputBits = firstBits ^ otherBits // 00010001

/*
=== Bitwise Left and Right shift operator (<<) (>>) ===
*/
let shiftBits:UInt8 = 4 //00000100 in binary
shiftBits << 1 // 00001000
shiftBits << 2 // 00010000
shiftBits << 5 // 10000000
shiftBits << 6 // 00000000
shiftBits >> 2 // 00000001

let pink: UInt32 = 0xCC6699
let redComponent: UInt32 = (pink & 0xFF0000) >> 16 // redComponent is 0xCC or 204
let greenComponent: UInt32 = (pink & 0x00FF00) >> 8 // greenComponent is 0x66, or 102
let blueComponent:UInt32 = pink & 0x0000FF  // blueComponent is 0x99 or 153

