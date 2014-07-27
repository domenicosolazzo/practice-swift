import UIKit
import SpriteKit

class Tile: SKSpriteNode {
    
    // Property isAlive
    var isAlive:Bool = false{
       didSet{
          self.hidden = !isAlive
       }
    }
    
    
}
