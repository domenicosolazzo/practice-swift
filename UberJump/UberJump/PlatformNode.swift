import SpriteKit

enum PlatformType:UInt32{
    case PLATFORM_NORMAL = 0
    case PLATFORM_BREAK = 1
}
class PlatformNode: GameObjectNode {
   
    var platformType:PlatformType?
    
    override func collisionWithPlayer(player:SKNode) -> Bool{
        if(player.physicsBody?.velocity.dy < 0){
            // 2
            player.physicsBody?.velocity = CGVectorMake(player.physicsBody!.velocity.dx, CGFloat(250));
            
            // 3
            // Remove if it is a Break type platform
            if (self.platformType! == PlatformType.PLATFORM_BREAK) {
                self.removeFromParent()
            }
        }
        return false
    }
}
