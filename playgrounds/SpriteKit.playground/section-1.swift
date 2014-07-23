// Playground SpriteKit
import Cocoa
import SpriteKit
import XCPlayground

class MyScene:SKScene{

    override func didMoveToView(view: SKView!) {
        var sprite = SKSpriteNode(color:NSColor.greenColor(), size: CGSize(width:50.0, height:50.0))
        sprite.name = "block"
        sprite.position = GCPoint(x:50.0, y:50.0)
        self.addChild(sprite)
    }
    
}
