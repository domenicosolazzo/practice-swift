import SpriteKit

class GameObjectNode: SKNode {
   
    // Called when a player physics body collides with the game object's physics body
    func collisionWithPlayer(player:SKNode) -> Bool{
        return false
    }
    
    
    // Called every frame to see if the game object should be removed from the scene
    func checkNodeRemoval(playerY:CGFloat){
        // Checks to see if the player node has traveled more than 300 points beyond this node
        if playerY > self.position.y + CGFloat(300){
            self.removeFromParent()
        }
    }
}
