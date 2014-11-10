//
//  GameScene.swift
//  CookieCrunch
//
//  Created by Domenico on 11/8/14

import SpriteKit

class GameScene: SKScene {
    var level:Level!
    
    let TileWidth: CGFloat = 32.0
    let TileHeight: CGFloat = 36.0
    
    let gameLayer: SKNode = SKNode()
    let cookiesLayer:SKNode = SKNode()
    let tilesLayer = SKNode()
    /// The column and row numbers of the cookie that the player 
    /// first touched when she started her swipe movement
    var swipeFromColumn: Int?
    var swipeFromRow: Int?
    
    override init(size: CGSize) {
        super.init(size: size)
        
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
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        
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
}
