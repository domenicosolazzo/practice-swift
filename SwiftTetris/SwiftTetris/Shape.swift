import Foundation
import SpriteKit

/// Number of orientations
let NumOrientations: UInt32 = 4

enum Orientation:Int, Printable{
    case Zero = 0, Ninety, OneEighty, TwoSeventy

    /// Required fromt the printable interface
    var description: String {
        switch self {
        case .Zero:
            return "0"
        case .Ninety:
            return "90"
        case .OneEighty:
            return "180"
        case .TwoSeventy:
            return "270"
        }
    }
    /// Random orientation
    static func random() -> Orientation {
        return Orientation(rawValue:Int(arc4random_uniform(NumOrientations)))!
    }
}