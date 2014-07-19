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
        for touch:AnyObject in touches{
            // Grab the touch location
            let location = touch.locationInNode(self)
            // Retrieve the sprite in that location
            // If the sprite at that location is matching play button, the do something!
            if( self.nodeAtPoint(location) == self.playButton){
                // Create a new PlayScene with the same size
                let playScene = PlayScene(size:self.size)
                let view = self.view as SKView
                // Ignore sibling order
                view.ignoresSiblingOrder = true
                
                // Scale mode for the new PlayScene
                scene.scaleMode = .ResizeFill
                
            }
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
