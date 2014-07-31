import SpriteKit
var _bearWalkingFrames = NSMutableArray()
var bear:SKSpriteNode = SKSpriteNode()
class GameScene: SKScene {
    
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
        
        // Find the velocity of the bear
        var screenSize:CGSize = self.frame.size
        // Take 3 seconds for the bear to move at a given position
        var bearVelocity = screenSize.width / 3.0
        
        // Figure it out the amount between bear position and the new positon
        var positionDifference = CGPointMake(location.x - bear.position.x, location.y - bear.position.y)
        
        // Figure out the actual length moved (Vector normalization)
        var distanceToMove = sqrt(positionDifference.x * positionDifference.x + positionDifference.y * positionDifference.y)
        
        // Figure out how long will take to move
        var moveDuration = distanceToMove / bearVelocity
        
        
        // Check the direction
        if location.x <= CGRectGetMidX(self.frame){
            // Walk left
            multiplierForDirection = 1
        }else{
            // Walk right
            multiplierForDirection = -1
        }
        
        // Change direction of the bear
        bear.xScale = fabs(bear.xScale) * multiplierForDirection
        self.walkingBear()
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        //self.walkingBear(_bearWalkingFrames)
    }
    
    func bearMoveEnded(){
        // Remove all the actions from the bear
        bear.removeAllActions()
    }
}
