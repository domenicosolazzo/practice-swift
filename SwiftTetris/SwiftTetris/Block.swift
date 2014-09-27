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
    
    /// This property is required if we are to adhere to the Printable protocol
    var description: String {
        return self.spriteName
    }
    
    /// This function returns a random choice among the colors found in BlockColor
    static func random() -> BlockColor {
        return BlockColor(rawValue: Int(arc4random_uniform(NumberOfColors)))!
    }
}

/// Hashable allows Block to be stored in Array2D.
class Block: Hashable, Printable {
    // Constants
    let color: BlockColor
    
    // Properties
    var column: Int
    var row: Int
    var sprite: SKSpriteNode?

    /// Shortcut for retrieving the block name
    var spriteName: String {
        return color.spriteName
    }
    
    /// Required from the Hashable interface
    var hashValue: Int {
        return self.column ^ self.row
    }
    
    /// Required from the Printable interface
    var description: String {
        return "\(color): [\(column), \(row)]"
    }
    
    init(column:Int, row:Int, color:BlockColor) {
        self.column = column
        self.row = row
        self.color = color
    }
}

/// Custom operator- == - when comparing one Block with another. It returns true if and only if both Blocks are in the same location and of the same color. This operator is required in order to support the Hashable protocol
func ==(lhs: Block, rhs: Block) -> Bool {
    return lhs.column == rhs.column && lhs.row == rhs.row && lhs.color.rawValue == rhs.color.rawValue
}