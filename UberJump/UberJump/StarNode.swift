import SpriteKit
enum StarTypes:UInt32{
    case STAR_NORMAL = 1
    case STAR_SPECIAL = 2
}

class StarNode: GameObjectNode {
   
    override func collisionWithPlayer(player: SKNode) -> Bool {
        
        // Boost the player up
        player.physicsBody.velocity = CGVectorMake(player.physicsBody.velocity.dx, CGFloat(400))
        
        // Remove the star from the scene
        self.removeFromParent()
        
        // The HUD needs updating to show the new stars and score
        return true
    }
}
