import SpriteKit

/// It defines the point size of each block sprite - in our case 20.0 x 20.0 - the lower of the available resolution options for each block image.
let BlockSize:CGFloat = 20.0

/// This variable that represent the slowest speed at which the shapes will travel.
/// It is setted to 600 milliseconds, which means that every 6/10ths of a second, our shape should descend by one row.
let TickLengthLevelOne = NSTimeInterval(600)

class GameScene: SKScene {
    /// GameScene's current tick length
    var tickLengthMillis = TickLengthLevelOne
    /// Last time we experience a tick
    var lastTick:NSDate?
    /// Closure block for each tick
    var tick:(() -> ())?
    
    /// It sits on top of the background layer
    let gameLayer = SKNode()
    /// It sits on top of the game layer
    let shapeLayer = SKNode()
    /// It declares a layer position which will give us an offset from the edge of the screen.
    let LayerPosition = CGPoint(x: 6, y: -6)

    /// Dictionary of SKTexture
    var textureCache = Dictionary<String, SKTexture>()

    
    override init(size: CGSize) {
        super.init(size:size)
        
        self.anchorPoint = CGPoint(x: 0, y: 1.0)
        // Add background
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: 0, y: 0)
        background.anchorPoint = CGPoint(x: 0, y: 1.0)
        self.addChild(background)
        
        // Adding the game layer
        self.addChild(gameLayer)
        
        // Gameboard
        let gameBoardTexture = SKTexture(imageNamed: "gameboard")
        
    }
    

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        if lastTick == nil { // The game is paused
            return
        }
        /// Recover the time passed since the last execution of update by invoking timeIntervalSinceNow on our lastTick object.
        var timePassed = lastTick!.timeIntervalSinceNow * -1000.0
        if timePassed > tickLengthMillis {
            lastTick = NSDate()
            tick?()
        }

    }
    /// Accessors
    func startTicking() {
        lastTick = NSDate()
    }
    
    
    func stopTicking() {
        lastTick = nil
    }
    
}
