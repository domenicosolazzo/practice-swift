// Enumerations
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
println(char)