import SpriteKit


class GameScene: SKScene {
    var background:SKSpriteNode = SKSpriteNode()
    var selectedNode:SKSpriteNode = SKSpriteNode()
    let kAnimalNodeName:String = "movable"
    
    override func didMoveToView(view: SKView) {
        
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
