import SpriteKit

class GameScene: SKScene {
    
    override init(size: CGSize) {
        super.init(size:size)
        
    }
    

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
