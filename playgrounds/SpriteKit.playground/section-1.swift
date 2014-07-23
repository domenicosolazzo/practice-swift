// Playground SpriteKit
import Cocoa
import SpriteKit
import XCPlayground

class MyScene:SKScene{

    override func didMoveToView(view: SKView!) {
        var sprite = SKSpriteNode(color:NSColor.greenColor(), size: CGSize(width:50.0, height:50.0))
        sprite.name = "block"
        
    }
}
