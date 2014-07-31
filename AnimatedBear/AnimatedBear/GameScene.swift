import SpriteKit
var _bearWalkingFrames = NSMutableArray()
class GameScene: SKScene {
    var bear:SKSpriteNode = SKSpriteNode()
    
    init(coder aDecoder: NSCoder!){
        super.init(coder: aDecoder)
        self.initialization()
    }
    
    func walkingBear(){
        SKAction.runAction(SKAction.animateWithTextures(_bearWalkingFrames, timePerFrame: 0.1), onChildWithName:"ciao"  )
    }
    
    func initialization(){
        // Add background color
        self.backgroundColor = SKColor.blackColor()
        
        // Load the atlas
        var textureAtlas:SKTextureAtlas = SKTextureAtlas(named: "BearImages")
        
        // Gather all the frames
        var numImages = textureAtlas.textureNames.count
        var tempArray:NSMutableArray = NSMutableArray()
        for i in 1...numImages/2{
            var textureName = "bear\(i)~ipad"
            tempArray.addObject(textureAtlas.textureNamed(textureName))
        }
        
        _bearWalkingFrames = tempArray
        // Create the first sprite
        bear = SKSpriteNode(texture: tempArray[0] as SKTexture)
        // Set the position to the center of the screen
        bear.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        // Add the bear to the view
        self.addChild(bear)
        // Walk in place
        self.walkingBear()
        
    }
    override func didMoveToView(view: SKView) {
        
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
    }
   
    override func touchesEnded(touches: NSSet!, withEvent event: UIEvent!) {
        // Getting the location
        var location:CGPoint = touches.anyObject().locationInNode(self)
        
        // Multiplier for the direction
        var multiplierForDirection:CGFloat = 1
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        //self.walkingBear(_bearWalkingFrames)
    }
}
