import SpriteKit


class GameScene: SKScene {
    var _background:SKSpriteNode = SKSpriteNode()
    var _selectedNode:SKSpriteNode = SKSpriteNode()
    let _kAnimalNodeName:String = "movable"
    
    // Constructor
    
    init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
        
        // Background
        _background = SKSpriteNode(imageNamed: "blue-shooting-stars")
        _background.name = "background"
        _background.anchorPoint = CGPointZero
        self.addChild(_background)
        
    }
    
    override func didMoveToView(view: SKView) {
        
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
