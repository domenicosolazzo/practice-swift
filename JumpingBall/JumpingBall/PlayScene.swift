import SpriteKit

// Sprite node for the bar
let runningBar = SKSpriteNode(imageNamed: "bar")

class PlayScene: SKScene{
    override func didMoveToView(view: SKView!) {
        self.backgroundColor = UIColor(hex: 0x809DFF)
        
        // Set the anchor point of the running bar at (0, 0.5)
        self.runningBar.anchorPoint = CGPointMake(0, 0.5)   
    }
    
    /// Update the scene: It will run every single frame
    override func update(currentTime: NSTimeInterval) {
        
    }
}
