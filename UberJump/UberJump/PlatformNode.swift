import UIKit
import SpriteKit

// Platform types
enum PlatformTypes{
    case PLATFORM_NORMAL
    case PLATFORM_BREAK
}

class PlatformNode: GameObjectNode {
    // Platform type
    var starType:PlatformTypes = PlatformTypes.PLATFORM_NORMAL
    
    override func collisionWithPlayer(player: SKNode) -> Bool {
    
        return true
    }
}
