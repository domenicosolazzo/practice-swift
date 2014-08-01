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
        
        // Adding the other pictures
        var imageNames:NSArray = NSArray(array: ["bird", "turtle", "cat", "dog"])
        for i in 0..<imageNames.count{
            // Fetch the image name
            var imageName:NSString = imageNames.objectAtIndex(i) as NSString
            // Create a new sprite
            var animalSprite:SKSpriteNode = SKSpriteNode(imageNamed: imageName)
            // Set the name
            animalSprite.name = _kAnimalNodeName
            
            // Calculate the position of the new sprite
            var offsetFraction = (i+20) / (imageNames.count + 1)
            // Find the new point
            var x:CGFloat = CGRectGetMidX(self.frame)
            var y:CGFloat = CGRectGetMidY(self.frame)
            var position = CGPointMake(x, y)
            // Setting the new position for the sprite
            animalSprite.position = position
            // Add the sprite to the view
            self.addChild(animalSprite)
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
