import SpriteKit

/// How many colors are available
let NumberOfColors: UInt32 = 6

/// Classes, structures and enums which implement Printable are capable of generating human-readable strings when debugging or printing their value to the console.
enum BlockColor: Int, Printable {

    case Blue = 0, Orange, Purple, Red, Teal, Yellow
    
    /// Computed variable for getting the sprite name
    var spriteName: String {
        switch self {
        case .Blue:
            return "blue"
        case .Orange:
            return "orange"
        case .Purple:
            return "purple"
        case .Red:
            return "red"
        case .Teal:
            return "teal"
        case .Yellow:
            return "yellow"
        }
    }

}