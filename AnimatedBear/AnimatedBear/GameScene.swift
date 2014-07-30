import SpriteKit

class GameScene: SKScene {
    var bear:SKSpriteNode = SKSpriteNode()
    var bearWalkingFrames:NSMutableArray = NSMutableArray()
    
    // Constructor
    init(size: CGSize){
        super.init(size: size)
        
        // Add background color
        self.backgroundColor = SKColor.blackColor()
        
        // Load the atlas
        var textureAtlas:SKTextureAtlas = SKTextureAtlas(named: "BearImages")
        
        // Gather all the frames
        var numImages = textureAtlas.textureNames.count
        for i in 1...numImages/2{
            var textureName = "bear\(i)"
            var textureTemp:SKTexture = textureAtlas.textureNamed(textureName)
            bearWalkingFrames.addObject(textureTemp)
        }
    }
    
    override func didMoveToView(view: SKView) {
        
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
