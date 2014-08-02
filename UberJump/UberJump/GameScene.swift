
import SpriteKit

// Midground node
var midgroundNode: SKNode = SKNode()
// Foreground node
var foregroundNode: SKNode = SKNode()
// Hud node
var hudNode: SKNode = SKNode()


class GameScene: SKScene {
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
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    func initialization(){
        self.backgroundColor = UIColor(red:1, green: 1, blue: 1, alpha: 1)
        
        // Add the foreground node to the scene
        self.addChild(foregroundNode)
    
        var backgroundNode = self.createBackground()
        self.addChild(backgroundNode)
        
        var player = self.createPlayer()
        foregroundNode.addChild(player)
        
        // Add gravity
        self.physicsWorld.gravity = CGVectorMake(CGFloat(0), CGFloat(-0.2))
    }
    
    func createBackground() -> SKNode{
        var backgroundNode: SKNode = SKNode()
        // Go through all the background images
        for i in 0...20{
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
    
    func createPlayer() -> SKNode{
        var playerNode:SKNode = SKNode()
        // Set the position
        playerNode.position = CGPointMake(CGFloat(160), CGFloat(80))
        
        // Create the player sprite
        var sprite :SKSpriteNode = SKSpriteNode(imageNamed: "Player")
        
        // Add the sprite to the player node
        playerNode.addChild(sprite)
        
        // Add physic body to the player node
        playerNode.physicsBody = SKPhysicsBody(circleOfRadius: sprite.size.width / 2)
        
        return playerNode
    }
}
