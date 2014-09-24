import UIKit

class GameState: NSObject {
    var _score:Int = 0
    var _highScore:Int = 0
    var _stars:Int = 0
    
    class var sharedInstance :GameState {
        struct Singleton {
            static let instance = GameState()
        }
        
        return Singleton.instance
    }
    
}
