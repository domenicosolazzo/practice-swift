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
        // Category bitmask
        alien.physicsBody.categoryBitMask = alienCategory
        // Contact test bit mask
        alien.physicsBody.contactTestBitMask = photonTorpedoCategory
        // Collision bit mask
        alien.physicsBody.collisionBitMask = 0
        
        
        // MinX for the alien
        let minX = alien.size.width / 2
        // MaxX for the alien
        let maxX = self.frame.size.width - alien.size.width/2
        // Range
        let range = maxX - minX
        // Random position
        var position:CGFloat = ((CGFloat)arc4random()) % CGFloat(range) + CGFloat(minX)
        // Positioning the alien: alien will be off-screen at this point
        alien.position = CGPointMake(position, self.frame.size.height + alien.size.height)
        
        // Add the alien to the view
        self.addChild(alien)
        
        // Adding some animation for the alien
        let minDuration = 2
        let maxDuration = 4
        let rangeDuration = maxDuration - minDuration
        var duration = Int(arc4random()) % Int(rangeDuration) + Int(maxDuration)
        
        
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
