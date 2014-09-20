//
//  GameScene.swift
//  UberJump
//
//  Created by Domenico Solazzo on 9/20/14.
//  Copyright (c) 2014 Domenico Solazzo. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    var _backgroundNode:SKNode?
    var _foregroundNode:SKNode?
    var _midgroundNode:SKNode?
    var _hudNode:SKNode?
    
    override init(size: CGSize) {
        super.init(size: size)
        self.initialization()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialization()
    }
    
    func initialization(){
        self.backgroundColor = SKColor.whiteColor()
        
        /// Background Node
        _backgroundNode = self.createBackgroundNode()
        self.addChild(_backgroundNode!)
        
        /// Foreground Node
        _foregroundNode = SKNode()
        self.addChild(_foregroundNode!)
    }
    override func didMoveToView(view: SKView) {
        
    }

    /// Create a background node
    func createBackgroundNode() -> SKNode{
        
        var backgroundNode:SKNode = SKNode()
        
        for count in 0...20{
            var backgroundImage = NSString(format:"Background%02d", count+1) as String
            var spriteNode:SKSpriteNode = SKSpriteNode(imageNamed: backgroundImage)
            spriteNode.anchorPoint = CGPointMake(CGFloat(0.5), CGFloat(0))
            spriteNode.position = CGPointMake(CGFloat(160), CGFloat(64 * count))
            
            backgroundNode.addChild(spriteNode)
            
        }
        return backgroundNode
    }
    
    /// Create a player
    func createPlayer() -> SKNode{
        var player: SKNode = SKNode()
        player.position = CGPointMake(CGFloat(180), CGFloat(64))
    
        var sprite = SKSpriteNode(imageNamed: "Player")
        player.addChild(sprite)
        
        return player
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
