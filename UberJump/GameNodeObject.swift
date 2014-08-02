import SpriteKit

class GameNodeObject: SKNode {
   
    // Called when a player physics body collides with the game object's physics body
    func collisionWithPlayer(player:SKNode) -> Bool{
        return false
    }
    
}
