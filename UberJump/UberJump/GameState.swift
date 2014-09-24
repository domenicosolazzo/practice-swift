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
    
    override init(){
        // Init
        _score = 0
        _highScore = 0
        _stars = 0
        
        // Load game state
        var defaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        var highScore = defaults.objectForKey("highScore")
        
        if let y = highScore as? Int {
            _highScore = y
        }
        
        var stars = defaults.objectForKey("stars")
        if let y = stars as? Int{
            _stars = y
        }
    }

    
}
