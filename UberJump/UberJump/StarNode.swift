import SpriteKit
import AVFoundation

enum StarTypes{
    case STAR_NORMAL
    case STAR_SPECIAL
}

class StarNode: GameObjectNode {
    // Star type
    var starType:StarTypes = StarTypes.STAR_NORMAL
    // Star sound
    var starSound:SKAction = SKAction.playSoundFileNamed("StarPing.wav", waitForCompletion: false)
    
    override func collisionWithPlayer(player: SKNode) -> Bool {
        
        // Boost the player up
        player.physicsBody.velocity = CGVectorMake(player.physicsBody.velocity.dx, CGFloat(400))
        
        // play sound
        self.parent.runAction(self.starSound)
        
        // Remove the star from the scene
        self.removeFromParent()
        
        // The HUD needs updating to show the new stars and score
        return true
    }
}
