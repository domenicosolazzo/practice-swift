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
    }
    
    override func didMoveToView(view: SKView) {
        
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
