
import SpriteKit

class GameObjectNode: SKNode {
   
    func collisionWithPlayer(player:SKNode) -> Bool{
        return false
    }
    
    func checkNodeRemoval(playerY:CGFloat){
        /// checks to see if the player node has traveled more than 300 points beyond this node. 
        if (playerY > self.position.y + CGFloat(300)) {
            self.removeFromParent()
        }
    }
}
