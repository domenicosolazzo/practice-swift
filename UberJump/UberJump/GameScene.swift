
import SpriteKit

// Midground node
var midgroundNode: SKNode = SKNode()
// Foreground node
var foregroundNode: SKNode = SKNode()
// Hud node
var hudNode: SKNode = SKNode()
// Player node
var playerNode:SKNode = SKNode()

// Enumeration
enum ObjectTypes:UInt32{
    case Hero = 1
    case Star = 2
    case Platform = 3
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    init(size: CGSize) {
        super.init(size: size)
        self.initialization()
    }
    
    init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
        self.initialization()
        
    }
    
    override func didMoveToView(view: SKView) {
        
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        // If we're already playing, ignore touches
        if playerNode.physicsBody.dynamic {
            return
        }
        
        // Remove the Tap to Start node
        hudNode.removeFromParent();
        
        // Start the player by putting them into the physics simulation
        playerNode.physicsBody.dynamic = true;
        
        // Give the player node an initial upward impulse to get them started
        playerNode.physicsBody.applyImpulse(CGVectorMake(CGFloat(0), CGFloat(20)))

    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    func didBeginContact(contact: SKPhysicsContact!) {
        var updateHUD = false
        var other:GameObjectNode = GameObjectNode()
        
        if contact.bodyA.node == playerNode{
            other = contact.bodyB.node as GameObjectNode
        }else{
            other = contact.bodyA.node as GameObjectNode
        }
        
        updateHUD = other.collisionWithPlayer(playerNode)
        
        if updateHUD{
        
        }
    }
    
    func initialization(){
        // Set the contact delegate
        self.physicsWorld.contactDelegate = self
        
        // Background color
        self.backgroundColor = UIColor(red:1, green: 1, blue: 1, alpha: 1)
        
        // Add the foreground node to the scene
        self.addChild(foregroundNode)
    
        var backgroundNode = self.createBackground()
        self.addChild(backgroundNode)
        
        self.createPlayer()
        foregroundNode.addChild(playerNode)
        
        // Create tap to Start
        self.createTapToStart()
        foregroundNode.addChild(hudNode)
        
        // Create a star
        var star = self.createStarAtPosition(CGPointMake(160, 200), StarTypes.STAR_SPECIAL)
        foregroundNode.addChild(star)
        
        // Add gravity
        self.physicsWorld.gravity = CGVectorMake(CGFloat(0), CGFloat(-0.2))
        
        
    }
    
    func createBackground() -> SKNode{
        var backgroundNode: SKNode = SKNode()
        // Go through all the background images
        for i in 0..<20{
            var formatter : NSString = NSString(format: "%02d", i+1)
            var backgroundName = "Background\(formatter)"
            
            var node = SKSpriteNode(imageNamed: backgroundName)
            node.anchorPoint = CGPointMake(0.5, 0.0)
            node.position = CGPointMake(CGFloat(160), CGFloat(i * 64))
            
            backgroundNode.addChild(node)
        }
        
        // Add the background node to the scene
        return backgroundNode
    }
    
    func createPlayer(){
        // Set the position
        playerNode.position = CGPointMake(CGFloat(160), CGFloat(80))
        
        // Create the player sprite
        var sprite :SKSpriteNode = SKSpriteNode(imageNamed: "Player")
        
        // Add the sprite to the player node
        playerNode.addChild(sprite)
        
        // Add physic body to the player node
        playerNode.physicsBody = SKPhysicsBody(circleOfRadius: sprite.size.width / 2)
        
        // The player is dynamic
        playerNode.physicsBody.dynamic = false
        
        // No rotation
        playerNode.physicsBody.allowsRotation = false
        
        // The player node will not lose momentum during collisions
        playerNode.physicsBody.restitution = 1.0;
        // Avoid friction and dampling
        playerNode.physicsBody.friction = 0.0;
        playerNode.physicsBody.angularDamping = 0.0;
        playerNode.physicsBody.linearDamping = 0.0;
        
        // Since this is a fast-moving game, you ask Sprite Kit to use precise collision detection for the player node’s physics body.
        playerNode.physicsBody.usesPreciseCollisionDetection = true
        
        // Category for the player
        playerNode.physicsBody.categoryBitMask = ObjectTypes.Hero.toRaw()
        // No collision for the player
        playerNode.physicsBody.collisionBitMask = 0
        // Contact test
        playerNode.physicsBody.contactTestBitMask = ObjectTypes.Star.toRaw() | ObjectTypes.Platform.toRaw()
    }
    
    func createTapToStart(){
        // Sprite
        var sprite = SKSpriteNode(imageNamed: "TapToStart")
        sprite.position = CGPointMake(CGFloat(160), CGFloat(180))
        
        // Add the sprite to the hud node
        hudNode.addChild(sprite)
    }
    
    func createStarAtPosition(position:CGPoint, starType:StarTypes) -> SKNode{
        // Create a SKNode
        var starNode = StarNode()
        // Star position
        starNode.position = position
        // Star name
        starNode.name = "STAR_NODE"
        // Star type
        starNode.starType = starType
        
        // Add a sprite for the star
        var sprite = SKSpriteNode(imageNamed: "Star")
        
        // Add the sprite to the star node
        starNode.addChild(sprite)
        
        // Add a physic body to the star
        starNode.physicsBody = SKPhysicsBody(circleOfRadius: sprite.size.width / 2)
        // The star is static
        starNode.physicsBody.dynamic = false
        // Category
        starNode.physicsBody.categoryBitMask = ObjectTypes.Star.toRaw()
        // No collision
        starNode.physicsBody.collisionBitMask = 0
        
        return starNode
    }
}
