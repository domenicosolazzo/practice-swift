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
    var _tapToStartNode:SKNode?
    var _playerNode:SKNode?
    
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
        
        /// Player node
        _playerNode = self.createPlayer()
        _foregroundNode?.addChild(_playerNode!)
        
        /// Hud node
        _hudNode = self.createHud()
        self.addChild(_hudNode!)
        
        // Change gravity
        self.physicsWorld.gravity = CGVectorMake(CGFloat(0), CGFloat(-2))
    }
    override func didMoveToView(view: SKView) {
        
    }

    /// Create a background node
    func createBackgroundNode() -> SKNode{
        
        var backgroundNode:SKNode = SKNode()
        
        for count in 0..<20{
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
        player.position = CGPointMake(CGFloat(160), CGFloat(64))
    
        var sprite = SKSpriteNode(imageNamed: "Player")
        
        /// Add physics
        player.physicsBody = SKPhysicsBody(circleOfRadius: CGFloat(sprite.size.width/2))
        /// Player is dynamic. It is false until the game starts
        player.physicsBody?.dynamic = false
        /// Player node to remain upright at all times
        player.physicsBody?.allowsRotation = false
        /// Physics body will not lose any of its momentum during collisions
        player.physicsBody?.restitution = CGFloat(1)
        /// No friction
        player.physicsBody?.friction = CGFloat(0)
        /// No linear damping
        player.physicsBody?.linearDamping = CGFloat(0)
        /// No angular damping
        player.physicsBody?.angularDamping = CGFloat(0)
        
        /// Add sprite to the player node
        player.addChild(sprite)
        
        return player
    }
    
    func createHud() -> SKNode{
        var hudNode:SKNode = SKNode()
        _tapToStartNode = SKSpriteNode(imageNamed: "TapToStart")
        _tapToStartNode?.position = CGPointMake(CGFloat(160), CGFloat(180))
        
        hudNode.addChild(_tapToStartNode!)
        return hudNode
    }
   
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /// If we are already playing, ignore touches
        if(self._playerNode?.physicsBody?.dynamic == true){
            return
        }
        
    }
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
