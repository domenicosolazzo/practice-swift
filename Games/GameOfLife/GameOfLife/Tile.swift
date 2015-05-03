import UIKit
import SpriteKit

class Tile: SKSpriteNode {
    // Number of living neighbors
    var numLivingNeighbors = 0
    
    // Property isAlive
    var isAlive:Bool = false{
       didSet{
          self.hidden = !isAlive
       }
    }
    
    
}
