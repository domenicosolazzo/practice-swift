// Enumerations
/**
An enumeration defines a common type for a a group of related values
and enables you to work with those values in a type-safe way within
your code
*/
import Cocoa

enum Planet{
    case Mercury, Venus, Earth, Mars,
        Jupiter, Saturn, Uranus, Neptune
    
}

var earth = Planet.Earth

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

var char = ASCIIControlCharacter.Tab.toRaw()

// FromRaw
var val = ASCIIControlCharacter.fromRaw("\t")


