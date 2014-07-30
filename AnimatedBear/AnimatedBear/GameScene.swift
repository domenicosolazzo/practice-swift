import SpriteKit

class GameScene: SKScene {
    var bear:SKSpriteNode = SKSpriteNode()
    var bearWalkingFrames:NSMutableArray = NSMutableArray()
    
    // Constructor
    
    init(coder aDecoder: NSCoder!){
        super.init(coder: aDecoder)
        self.initialization()
    }
    
    func walkingBear(){
        SKAction.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(self.bearWalkingFrames, timePerFrame: 0.1.floatingPointClass, resize: false, restore: true)), onChildWithName: "walkingInPlaceBear")
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
        
        self.bearWalkingFrames = tempArray
        // Create the first sprite
        bear = SKSpriteNode(texture: bearWalkingFrames[0] as SKTexture)
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
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
