import SpriteKit

class GameScene: SKScene {
    // Play button node
    let playButton = SKSpriteNode(imageNamed: "play")
    
    override func didMoveToView(view: SKView) {
        // Position the play button in the middle of the screen
        // It position the button in the middle of the frame.
        self.playButton.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        
        // Add the button to the screen
        self.addChild(self.playButton)
        
        // Set the background color
        self.backgroundColor = UIColor(hex: 0x809DFF)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
