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
        let gameBoard = SKSpriteNode(texture: gameBoardTexture, size: CGSizeMake(BlockSize * CGFloat(NumColumns), BlockSize * CGFloat(NumRows)))
        gameBoard.anchorPoint = CGPoint(x:0, y:1.0)
        gameBoard.position = LayerPosition
        
        shapeLayer.position = LayerPosition
        shapeLayer.addChild(gameBoard)
        gameLayer.addChild(shapeLayer)
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
    
    /// This function returns the precise coordinate on the screen for where a block sprite belongs based on its row and column position. 
    /// Each sprite will be anchored at its center, therefore we need to find its center coordinate before placing it in our shapeLayer object.
    func pointForColumn(column: Int, row: Int) -> CGPoint {
        let x: CGFloat = LayerPosition.x + (CGFloat(column) * BlockSize) + (BlockSize / 2)
        let y: CGFloat = LayerPosition.y - ((CGFloat(row) * BlockSize) + (BlockSize / 2))
        return CGPointMake(x, y)
    }
    
    /// Add a shape for the first time to the scene as a preview shape
    func addPreviewShapeToScene(shape:Shape, completion:() -> ()) {
        for (idx, block) in enumerate(shape.blocks) {
            // It uses a dictionary to store copies of re-usable SKTexture objects since each shape will require multiple copies of the same image.
            var texture = textureCache[block.spriteName]
            if texture == nil {
                texture = SKTexture(imageNamed: block.spriteName)
                textureCache[block.spriteName] = texture
            }
            let sprite = SKSpriteNode(texture: texture)
            
            // It uses our convenient pointForColumn(Int, Int) method to place each block's sprite in the proper location. We start it at row - 2, such that the preview piece animates smoothly into place from a higher location.
            sprite.position = pointForColumn(block.column, row:block.row - 2)
            shapeLayer.addChild(sprite)
            block.sprite = sprite
            
            // Animation
            sprite.alpha = 0
            
            // It is responsible for visually manipulating SKNode objects. Each block will fade and move into place as it appears as part of the next piece. It will move two rows down and fade from complete transparency to 70% opacity. This small design choice lets the player ignore the preview piece easily if they so choose since it will be duller than the active moving piece.
            let moveAction = SKAction.moveTo(pointForColumn(block.column, row: block.row), duration: NSTimeInterval(0.2))
            moveAction.timingMode = .EaseOut
            let fadeInAction = SKAction.fadeAlphaTo(0.7, duration: 0.4)
            fadeInAction.timingMode = .EaseOut
            sprite.runAction(SKAction.group([moveAction, fadeInAction]))
        }
        runAction(SKAction.waitForDuration(0.4), completion: completion)
    }
    
    /// Move the preview shape
    func movePreviewShape(shape:Shape, completion:() -> ()) {
        for (idx, block) in enumerate(shape.blocks) {
            let sprite = block.sprite!
            let moveTo = pointForColumn(block.column, row:block.row)
            let moveToAction:SKAction = SKAction.moveTo(moveTo, duration: 0.2)
            moveToAction.timingMode = .EaseOut
            sprite.runAction(
                SKAction.group([moveToAction, SKAction.fadeAlphaTo(1.0, duration: 0.2)]), completion:nil)
        }
        runAction(SKAction.waitForDuration(0.2), completion: completion)
    }
    
    /// Redraw shape
    func redrawShape(shape:Shape, completion:() -> ()) {
        for (idx, block) in enumerate(shape.blocks) {
            let sprite = block.sprite!
            let moveTo = pointForColumn(block.column, row:block.row)
            let moveToAction:SKAction = SKAction.moveTo(moveTo, duration: 0.05)
            moveToAction.timingMode = .EaseOut
            sprite.runAction(moveToAction, completion: nil)
        }
        runAction(SKAction.waitForDuration(0.05), completion: completion)
    }
    
}
