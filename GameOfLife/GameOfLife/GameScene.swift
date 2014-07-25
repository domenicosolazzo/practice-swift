import SpriteKit

class GameScene: SKScene {
    let _gridWidth = 400
    let _gridHeight = 300
    let _numRows = 8
    let _numCols = 10
    let _gridLowerLeftCorner: CGPoint = CGPoint(x: 158, y:10)
    
    override func didMoveToView(view: SKView) {
        let background = SKSpriteNode(imageNamed: "background.pmg")
        background.anchorPoint = CGPoint(x:0, y:0)
        background.size = self.size
        background.zPosition = -2
        self.addChild(background)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
