import SpriteKit
import AVFoundation

enum StarType:UInt32{
    case STAR_NORMAL = 1
    case STAR_SPECIAL = 2
}
class StarNode: GameObjectNode {
   
    // Star Type
    var starType:StarType?
    
    override func collisionWithPlayer(player:SKNode) -> Bool{
        // Boost the player up
        var dx:CGFloat = player.physicsBody!.velocity.dx
        
        player.physicsBody?.velocity = CGVectorMake(dx, CGFloat(400))
        // Remove this star
        self.removeFromParent()
        
        // The HUD needs updating to show the new stars and score
        return true;
    }
}
