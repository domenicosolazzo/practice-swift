//
//  GameScene.swift
//  CookieCrunch
//
//  Created by Domenico on 11/8/14

import SpriteKit

class GameScene: SKScene {
    var level:Level!
    
    var selectionSprite = SKSpriteNode()

    
    let TileWidth: CGFloat = 32.0
    let TileHeight: CGFloat = 36.0
    
    let gameLayer: SKNode = SKNode()
    let cookiesLayer:SKNode = SKNode()
    let tilesLayer = SKNode()
    /// The column and row numbers of the cookie that the player 
    /// first touched when she started her swipe movement
    var swipeFromColumn: Int?
    var swipeFromRow: Int?
    
    // Sounds
    let swapSound = SKAction.playSoundFileNamed("Chomp.wav", waitForCompletion: false)
    let invalidSwapSound = SKAction.playSoundFileNamed("Error.wav", waitForCompletion: false)
    let matchSound = SKAction.playSoundFileNamed("Ka-Ching.wav", waitForCompletion: false)
    let fallingCookieSound = SKAction.playSoundFileNamed("Scrape.wav", waitForCompletion: false)
    let addCookieSound = SKAction.playSoundFileNamed("Drip.wav", waitForCompletion: false)
    
    /// Closure
    var swipeHandler: ((Swap) -> ())?
    
    override init(size: CGSize) {
        super.init(size: size)
        
        swipeFromColumn = nil
        swipeFromRow = nil
        
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        let background = SKSpriteNode(imageNamed: "Background")
        self.addChild(background)
        
        self.addChild(gameLayer)
        
        let layerPosition = CGPoint(
            x: -TileWidth * CGFloat(NumColumns) / 2,
            y: -TileHeight * CGFloat(NumRows) / 2)
        self.cookiesLayer.position = layerPosition
        tilesLayer.position = layerPosition
        gameLayer.addChild(cookiesLayer)

    }
    
    /// This loops through all the rows and columns. 
    /// If there is a tile at that grid square, then it creates a new tile sprite and adds it to the tiles layer
    func addTiles() {
        for row in 0..<NumRows {
            for column in 0..<NumColumns {
                if let tile = level.tileAtColumn(column, row: row) {
                    let tileNode = SKSpriteNode(imageNamed: "Tile")
                    tileNode.position = pointForColumn(column, row: row)
                    tilesLayer.addChild(tileNode)
                }
            }
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToView(view: SKView) {
        
    }
    
    /// This method takes a CGPoint that is relative to the cookiesLayer and converts it into column and row numbers
    func convertPoint(point: CGPoint) -> (success: Bool, column: Int, row: Int) {
        if point.x >= 0 && point.x < CGFloat(NumColumns)*TileWidth &&
            point.y >= 0 && point.y < CGFloat(NumRows)*TileHeight {
                return (true, Int(point.x / TileWidth), Int(point.y / TileHeight))
        } else {
            return (false, 0, 0)  // invalid location
        }
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        // It converts the touch location to a point relative to the cookiesLayer
        let touch = touches.anyObject() as UITouch
        let location = touch.locationInNode(cookiesLayer)
        // finds out if the touch is inside a square on the level grid
        let (success, column, row) = convertPoint(location)
        if success {
            // the method verifies that the touch is on a cookie rather than on an empty square
            if let cookie = level.cookieAtColumn(column, row: row) {
                // it records the column and row where the swipe started so you can compare them later to find the direction of the swipe
                swipeFromColumn = column
                swipeFromRow = row
                
                // Show highlighted cookie
                showSelectionIndicatorForCookie(cookie)
            }
        }
        
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        // either the swipe began outside the valid area or the game has already swapped the cookies and you need to ignore the rest of the motion
        if swipeFromColumn == nil { return }
        
        // calculate the row and column numbers currently under the player’s finger
        let touch = touches.anyObject() as UITouch
        let location = touch.locationInNode(cookiesLayer)
        
        let (success, column, row) = convertPoint(location)
        if success {
            
            // Direction of the player’s swipe by simply comparing the new column and row numbers to the previous ones
            var horzDelta = 0, vertDelta = 0
            if column < swipeFromColumn! {          // swipe left
                horzDelta = -1
            } else if column > swipeFromColumn! {   // swipe right
                horzDelta = 1
            } else if row < swipeFromRow! {         // swipe down
                vertDelta = -1
            } else if row > swipeFromRow! {         // swipe up
                vertDelta = 1
            }
            
            // The method only performs the swap if the player swiped out of the old square
            if horzDelta != 0 || vertDelta != 0 {
                trySwapHorizontal(horzDelta, vertical: vertDelta)
                // Remove highlighted cookie
                hideSelectionIndicator()
                
                // By setting swipeFromColumn back to nil, the game will ignore the rest of this swipe motion
                swipeFromColumn = nil
            }
        }
    }
   
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        swipeFromColumn = nil
        swipeFromRow = nil
        
        // If the user just taps on the screen rather than swipes, you want to fade out the highlighted sprite
        if selectionSprite.parent != nil && swipeFromColumn != nil {
            hideSelectionIndicator()
        }
    }
    
    override func touchesCancelled(touches: NSSet!, withEvent event: UIEvent!) {
        touchesEnded(touches, withEvent: event)
    }
    // Check if there are two cookies to swap
    func trySwapHorizontal(horzDelta: Int, vertical vertDelta: Int) {
        // calculate the column and row numbers of the cookie to swap with
        let toColumn = swipeFromColumn! + horzDelta
        let toRow = swipeFromRow! + vertDelta
        // Checking for the user swiping outside the grid
        if toColumn < 0 || toColumn >= NumColumns { return }
        if toRow < 0 || toRow >= NumRows { return }
        // Check if there is a cookie in the position
        if let toCookie = level.cookieAtColumn(toColumn, row: toRow) {
            if let fromCookie = level.cookieAtColumn(swipeFromColumn!, row: swipeFromRow!) {
                // valid swap!
                // Handle the swap using the swipeHandler closure
                if let handler = swipeHandler {
                    let swap = Swap(cookieA: fromCookie, cookieB: toCookie)
                    handler(swap)
                }
            }
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    /// Adding the sprites to the scene
    func addSpritesForCookies(cookies:Set<Cookie>){
        for cookie in cookies{
            let sprite = SKSpriteNode(imageNamed: cookie.cookieType.spriteName)
            sprite.position = pointForColumn(cookie.column, row: cookie.row)
            cookiesLayer.addChild(sprite)
            cookie.sprite = sprite
        }
    }
    
    func pointForColumn(column:Int, row:Int) -> CGPoint{
        return CGPoint(
            x:CGFloat(column)*TileWidth + TileWidth / 2,
            y: CGFloat(row)*TileHeight + TileHeight / 2
        )
    }
    
    func showSelectionIndicatorForCookie(cookie: Cookie) {
        if selectionSprite.parent != nil {
            selectionSprite.removeFromParent()
        }
        
        if let sprite = cookie.sprite {
            // It gets the name of the highlighted sprite image from the Cookie object and puts the corresponding texture on the selection sprite
            let texture = SKTexture(imageNamed: cookie.cookieType.highlightedSpriteName)
            selectionSprite.size = texture.size()
            selectionSprite.runAction(SKAction.setTexture(texture))
            
            // add the selection sprite as a child of the cookie sprite so that it moves along with the cookie sprite in the swap animation
            sprite.addChild(selectionSprite)
            // sprite visible by setting its alpha to 1
            selectionSprite.alpha = 1.0
        }
    }
    
    // It removes the selection sprite by fading it out
    func hideSelectionIndicator() {
        selectionSprite.runAction(SKAction.sequence([
            SKAction.fadeOutWithDuration(0.3),
            SKAction.removeFromParent()]))
    }
    
    /// Animating the swap of two cookies
    func animateSwap(swap: Swap, completion: () -> ()) {
        let spriteA = swap.cookieA.sprite!
        let spriteB = swap.cookieB.sprite!
        
        spriteA.zPosition = 100
        spriteB.zPosition = 90
        
        let Duration: NSTimeInterval = 0.3
        
        let moveA = SKAction.moveTo(spriteB.position, duration: Duration)
        moveA.timingMode = .EaseOut
        spriteA.runAction(moveA, completion: completion)
        
        let moveB = SKAction.moveTo(spriteA.position, duration: Duration)
        moveB.timingMode = .EaseOut
        spriteB.runAction(moveB)
        
        runAction(swapSound)
    }
    
    // it slides the cookies to their new positions and then immediately flips them back.
    func animateInvalidSwap(swap: Swap, completion: () -> ()) {
        let spriteA = swap.cookieA.sprite!
        let spriteB = swap.cookieB.sprite!
        
        spriteA.zPosition = 100
        spriteB.zPosition = 90
        
        let Duration: NSTimeInterval = 0.2
        
        let moveA = SKAction.moveTo(spriteB.position, duration: Duration)
        moveA.timingMode = .EaseOut
        
        let moveB = SKAction.moveTo(spriteA.position, duration: Duration)
        moveB.timingMode = .EaseOut
        
        spriteA.runAction(SKAction.sequence([moveA, moveB]), completion: completion)
        spriteB.runAction(SKAction.sequence([moveB, moveA]))
        
        runAction(invalidSwapSound)
    }
    
    // loops through all the chains and all the cookies in each chain, and then triggers the animations
    func animateMatchedCookies(chains: Set<Chain>, completion: () -> ()) {
        for chain in chains {
            for cookie in chain.cookies {
                if let sprite = cookie.sprite {
                    if sprite.actionForKey("removing") == nil {
                        let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                        scaleAction.timingMode = .EaseOut
                        sprite.runAction(SKAction.sequence([scaleAction, SKAction.removeFromParent()]),
                            withKey:"removing")
                    }
                }
            }
        }
        runAction(matchSound)
        runAction(SKAction.waitForDuration(0.3), completion: completion)
    }
}
