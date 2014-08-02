import UIKit
import SpriteKit

// Platform types
enum PlatformTypes{
    case PLATFORM_NORMAL
    case PLATFORM_BREAK
}

class PlatformNode: GameObjectNode {
    // Platform type
    var platformType:PlatformTypes = PlatformTypes.PLATFORM_NORMAL
    
    override func collisionWithPlayer(player: SKNode) -> Bool {
    
        /*
            The player node should only bounce if it hits a platform while falling,
            which is indicated by a negative dy value in its velocity. This check also ensures the player node doesn’t
            collide with platforms while moving up the screen
        */
        if player.physicsBody.velocity.dy < 0{
            // You give the player node a vertical boost to make it bounce off the platform
            player.physicsBody.velocity = CGVectorMake(player.physicsBody.velocity.dx, CGFloat(250))
        }
        
        if platformType == PlatformTypes.PLATFORM_BREAK{
            self.removeFromParent()
        }
        
        return false
    }
}
