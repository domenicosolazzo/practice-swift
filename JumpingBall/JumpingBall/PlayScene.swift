import SpriteKit

// Sprite node for the bar
let runningBar = SKSpriteNode(imageNamed: "bar")

class PlayScene: SKScene{
    override func didMoveToView(view: SKView!) {
        self.backgroundColor = UIColor(hex: 0x809DFF)
    }
}
