// Playground SpriteKit
import Cocoa
import SpriteKit
import XCPlayground

class MyScene:SKScene{
    var _previousTime = 0.0
    var _currentTime = 0.0
    var _deltaTime = 0.0
    
    override func didMoveToView(view: SKView!) {
        var sprite = SKSpriteNode(color:NSColor.greenColor(), size: CGSize(width:50.0, height:50.0))
        sprite.name = "block"
        sprite.position = CGPoint(x:50.0, y:50.0)
        self.addChild(sprite)
    }
    
}
