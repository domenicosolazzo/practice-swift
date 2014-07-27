import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    // Player
    var player:SKSpriteNode = SKSpriteNode()
    // Number of aliens destroyed
    var aliensDestroyed = 0
    // Used to decide when to add new aliens
    var lastYieldTimeInterval:NSTimeInterval = NSTimeInterval()
    var lastUpdateTimerInterval:NSTimeInterval = NSTimeInterval()
    
    // Alien category
    var alienCategory:UInt32 = 0x1 << 1
    // Photon torpedo category
    var photonTorpedoCategory:UInt32 = 0x1 << 0
    
    override func didMoveToView(view: SKView) {
        
    }
    
    init(size:CGSize){
        super.init(size: size)
        // Initialize the background with a black color
        self.backgroundColor = SKColor.blackColor()
        
        // Initialize the player
        player = SKSpriteNode(imageNamed: "shuttle")
        // Position of the player
        player.position = CGPointMake(self.frame.size.width/2, player.size.height/2 + 20)
        // Add the player to the game scene
        self.addChild(player)
        
        // Gravity: We do not want any gravity
        self.physicsWorld.gravity = CGVectorMake(0, 0)
        // Contact delegate for the physics world
        self.physicsWorld.contactDelegate = self
    }
    
    func addAlien(){
        var alien:SKSpriteNode = SKSpriteNode(imageNamed: "alien")
        // Add a physical body: Used for collision detection
        alien.physicsBody = SKPhysicsBody(rectangleOfSize: alien.size)
        // The object is dynamic: it is moved from the physic of the game scene
        alien.physicsBody.dynamic = true
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
