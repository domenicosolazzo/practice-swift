import UIKit
import SpriteKit


class GameViewController: UIViewController, SwiftrisDelegate, UIGestureRecognizerDelegate {
    var scene: GameScene!
    var swiftris:SwifTris!
    
    /// It keeps track of the last point on the screen at which a shape movement occurred or where a pan begins.
    var panPointReference:CGPoint?
    
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
    
    func nextShape() {
        let newShapes = swiftris.newShape()
        if let fallingShape = newShapes.fallingShape {
            self.scene.addPreviewShapeToScene(newShapes.nextShape!) {}
            self.scene.movePreviewShape(fallingShape) {
                
                self.view.userInteractionEnabled = true
                self.scene.startTicking()
            }
        }
    }
    @IBAction func didPan(sender: UIPanGestureRecognizer) {
        let currentPoint = sender.translationInView(self.view)
        if let originalPoint = panPointReference {
            
            if abs(currentPoint.x - originalPoint.x) > (BlockSize * 0.9) {
                
                if sender.velocityInView(self.view).x > CGFloat(0) {
                    swiftris.moveShapeRight()
                    panPointReference = currentPoint
                } else {
                    swiftris.moveShapeLeft()
                    panPointReference = currentPoint
                }
            }
        } else if sender.state == .Began {
            panPointReference = currentPoint
        }
    }
   
    @IBAction func didTap(sender: UITapGestureRecognizer) {
        swiftris.rotateShape()
    }
    
    
    func gameDidBegin(swiftris: SwifTris) {
        // The following is false when restarting a new game
        if swiftris.nextShape != nil && swiftris.nextShape!.blocks[0].sprite == nil {
            scene.addPreviewShapeToScene(swiftris.nextShape!) {
                self.nextShape()
            }
        } else {
            nextShape()
        }
    }
    
    func gameDidEnd(swiftris: SwifTris) {
        view.userInteractionEnabled = false
        scene.stopTicking()
    }
    
    func gameDidLevelUp(swiftris: SwifTris) {
        
    }
    
    func gameShapeDidDrop(swiftris: SwifTris) {
        
    }
    
    func gameShapeDidLand(swiftris: SwifTris) {
        scene.stopTicking()
        nextShape()
    }
    
    
    func gameShapeDidMove(swiftris: SwifTris) {
        scene.redrawShape(swiftris.fallingShape!) {}
    }

}
