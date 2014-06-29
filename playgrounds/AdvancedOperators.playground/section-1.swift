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
