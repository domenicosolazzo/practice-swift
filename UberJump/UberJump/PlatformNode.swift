import UIKit
import SpriteKit

// Platform types
enum PlatformTypes{
    case PLATFORM_NORMAL
    case PLATFORM_BREAK
}

class PlatformNode: GameObjectNode {
 
    override func collisionWithPlayer(player: SKNode) -> Bool {
    
        return true
    }
}
