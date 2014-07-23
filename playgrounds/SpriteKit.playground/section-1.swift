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
    
    override func update(currentTime: NSTimeInterval) {
        if _previousTime == 0.0 { _previousTime = _currentTime}
        // Delta
        _deltaTime = _currentTime - _previousTime
        
        _previousTime = _currentTime
        // Retrieve the sprite by name
        var block = self.childNodeWithName("block")
        // Update block position
        block.position = CGPoint(x: block.position.x + (20.0 * _deltaTime), y: block.position.y + (20.0 * _deltaTime))
    }
}
