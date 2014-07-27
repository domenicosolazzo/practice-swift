import UIKit
import SpriteKit

class GameOverScene: SKScene {
   
    init(size:CGSize, won:Bool){
        super.init(size: size)
        
        // Background color
        self.backgroundColor = SKColor.blackColor()
        
        // Create a new message
        var message:NSString = NSString()
        
        // Select the message based on the won variable
        if won{
            message = "You WON!"
        }else{
            message = "Game Over"
        }
        
        // Create a label initialized with a font name
        // P.S. Some useful fonts can be found at http://iosfonts.com
        var label:SKLabelNode = SKLabelNode(fontNamed: "HelveticaNeue")
        label.text = message
        // Add the font color
        label.fontColor = SKColor.whiteColor()
        // Add the position
        label.position = CGPointMake(self.size.width / 2, self.size.height / 2)
        
        self.addChild(label)
        
        // Run actions
        // - The user read the message for 3 seconds
        // - The user is redirected to the GameScene with a transition
        self.runAction(SKAction.sequence([ SKAction.waitForDuration(3),
            SKAction.runBlock({
                var transition:SKTransition = SKTransition.flipHorizontalWithDuration(0.5)
                var gameScene:GameScene = GameScene(size: self.size)
                self.view.presentScene(gameScene, transition: transition)   
                })
            ]))
    }
}
