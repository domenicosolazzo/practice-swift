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
        let position:CGFloat = CGFloat(Int(arc4random_uniform(UInt32(UInt(range ))))) + minX
        // Positioning the alien: alien will be off-screen at this point
        alien.position = CGPointMake(position, self.frame.size.height + alien.size.height)
        
        // Add the alien to the view
        self.addChild(alien)
        
        // Adding some animation for the alien
        let minDuration = 2
        let maxDuration = 4
        let rangeDuration = maxDuration - minDuration
        var duration = UInt32(arc4random()) % UInt32(rangeDuration) + UInt32(maxDuration)
        
        // Animation array
        var arrayAction:NSMutableArray = NSMutableArray()
        // Move the alien from their start to position to the bottom of the screen
        arrayAction.addObject(SKAction.moveTo(CGPointMake(position, CGFloat(-alien.size.height)), duration: NSTimeInterval(duration)))
        // Remove the object when is off screen
        arrayAction.addObject(SKAction.removeFromParent())
        
        // Run the actions
        alien.runAction(SKAction.sequence(arrayAction))
        
    }
    
    func updateWithTimeSinceLastUpdate(sinceLastUpdate:CFTimeInterval){
        lastYieldTimeInterval += sinceLastUpdate
        if lastYieldTimeInterval > 1{
            lastYieldTimeInterval = 0
            addAlien()
        }
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        var timeSinceLastUpdate = currentTime - lastUpdateTimerInterval
        lastUpdateTimerInterval = currentTime
        
        if timeSinceLastUpdate > 1 {
            timeSinceLastUpdate = 1/60
            lastUpdateTimerInterval = currentTime
        }
        
        updateWithTimeSinceLastUpdate(timeSinceLastUpdate)
    }
    
    // Add two vectors
    func vecAdd(a:CGPoint, b:CGPoint) -> CGPoint{
        return CGPointMake(a.x + b.x, a.y + b.y)
    }
    
    // Subtract two vectors
    func vecSub(a:CGPoint, b:CGPoint) -> CGPoint{
        return CGPointMake(a.x - b.x, a.y - b.y)
    }
    
    // Multiply a vector
    func vecMult(a:CGPoint, factor: CGFloat) -> CGPoint{
        return CGPointMake(a.x * factor, a.y * factor)
    }
}
