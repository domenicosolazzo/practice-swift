// Enumerations
/**
An enumeration defines a common type for a a group of related values
and enables you to work with those values in a type-safe way within
your code

Enumerations in Swift are first-class types in their own right.
They adopt many features traditionally supported only by classes,
such as computed properties to provide additional information about
the enumeration's value.
*/
import Cocoa

/**
========================================
======== Enumeration Syntax ============
========================================
**/
/**
Enumerations are created using the enum keyword and
place their entire definition within a pair of braces.

The values are called 'members values'.
Unline C, Swift enumerations members are not assigned a default integer value when
they are created. They are fully-fledged values on their own.

The case keyword indicates that a new line of member values is
about to be defined.
**/
enum Planet{
    case Mercury, Venus, Earth, Mars, // Multiple member values can appear separated by comma
        Jupiter, Saturn, Uranus, Neptune
    
}

var earth = Planet.Earth
/**
You can drop the Type in the following assignment because it is already known by Swift
**/
earth = .Mercury

enum Barcode{
    case UPCA(Int, Int, Int)
    case QRCode(String)
}

var productBarCode = Barcode.UPCA(20, 20, 100)

/**
======= RAW Values =======
*/
enum ASCIIControlCharacter: Character {
    case Tab = "\t"
    case LineFeed = "\n"
    case CarriageReturn = "\r"
}

var char = ASCIIControlCharacter.Tab.rawValue

// FromRaw
var val = ASCIIControlCharacter(rawValue: "\t")


