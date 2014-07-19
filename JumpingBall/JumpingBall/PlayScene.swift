import SpriteKit

// Sprite node for the bar
let runningBar = SKSpriteNode(imageNamed: "bar")

class PlayScene: SKScene{
    override func didMoveToView(view: SKView!) {
        self.backgroundColor = UIColor(hex: 0x809DFF)
    }
    
    /// Update the scene: It will run every single frame
    override func update(currentTime: NSTimeInterval) {
        
    }
}
