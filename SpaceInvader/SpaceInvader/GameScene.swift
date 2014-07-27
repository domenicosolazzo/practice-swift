import SpriteKit

class GameScene: SKScene {
    // Player
    var player:SKSpriteNode = SKSpriteNode()
    // Number of aliens destroyed
    var aliensDestroyed = 0
    // Used to decide when to add new aliens
    var lastYieldTimeInterval:NSTimeInterval = NSTimeInterval()
    var lastUpdateTimerInterval:NSTimeInterval = NSTimeInterval()
    
    override func didMoveToView(view: SKView) {
        
    }
    
    init(size:CGSize){
        super.init(size: size)
        // Initialize the background with a black color
        self.backgroundColor = SKColor.blackColor()
        
        // Initialize the player
        player = SKSpriteNode(imageNamed: "shuttle")
        // Position of the player
        player.position = CGPoint(x:self.frame.size.width/2, y:self.frame.size.height/2 + 20)
        // Add the player to the game scene
        self.addChild(player)
        
        // Gravity: We do not want any gravity
        self.physicsWorld.gravity = CGVectorMake(0, 0)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
