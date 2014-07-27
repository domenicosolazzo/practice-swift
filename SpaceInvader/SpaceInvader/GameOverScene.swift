import UIKit
import SpriteKit

class GameOverScene: SKScene {
   
    init(size:CGSize, won:Bool){
        super.init(size: size)
        
        // Create a new message
        var message:NSString = NSString()
        
        // Select the message based on the won variable
        if won{
            message = "You WON!"
        }else{
            message = "Game Over"
        }
    }
}
