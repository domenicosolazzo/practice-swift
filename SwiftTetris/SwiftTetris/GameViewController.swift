import UIKit
import SpriteKit


class GameViewController: UIViewController, SwiftrisDelegate {
    var scene: GameScene!
    var swiftris:SwifTris!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Configure the view.
        let skView = view as SKView
        skView.multipleTouchEnabled = false
        
        // Create and configure the scene.
        self.scene = GameScene(size: skView.bounds.size)
        self.scene.scaleMode = .AspectFill
        
        self.scene.tick = didTick
        
        swiftris = SwifTris()
        swiftris.delegate = self
        swiftris.beginGame()
        
        // Present the scene.
        skView.presentScene(scene)
        
        
        
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    /// It lowers the falling shape by one row and then asks GameScene to redraw the shape at its new location.
    func didTick() {
        swiftris.letShapeFall()
    }

}
