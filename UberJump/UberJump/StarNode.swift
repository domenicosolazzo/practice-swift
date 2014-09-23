import SpriteKit
import AVFoundation

enum StarType:UInt32{
    case STAR_NORMAL = 0
    case STAR_SPECIAL = 1
}
class StarNode: GameObjectNode {
   
    // Star Type
    var starType:StarType?
    // Sound action
    var _starSound:SKAction = SKAction.playSoundFileNamed("StarPing.wav", waitForCompletion: false)
    
    
    
    override func collisionWithPlayer(player:SKNode) -> Bool{
        // Boost the player up
        var dx:CGFloat = player.physicsBody!.velocity.dx
        
        player.physicsBody?.velocity = CGVectorMake(dx, CGFloat(400))
        
        // Run the sound
        self.parent!.runAction(self._starSound)
        
        // Remove this star
        self.removeFromParent()
        
        // The HUD needs updating to show the new stars and score
        return true;
    }
}
