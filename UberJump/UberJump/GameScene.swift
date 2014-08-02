
import SpriteKit

class GameScene: SKScene {
    init(size: CGSize) {
        super.init(size: size)
        self.initialization()
    }
    
    init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
        self.initialization()
        
    }
    
    override func didMoveToView(view: SKView) {
        
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    func initialization(){
        self.backgroundColor = UIColor(red:1, green: 1, blue: 1, alpha: 1)
    }
}
