//
//  GameScene.swift
//  UberJump
//
//  Created by Domenico Solazzo on 9/20/14.
//  Copyright (c) 2014 Domenico Solazzo. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
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
        
        var backgroundNode:SKNode  = self.createBackgroundNode()
        self.addChild(backgroundNode)
    }
    override func didMoveToView(view: SKView) {
        
    }
    func createBackgroundNode() -> SKNode{
        // Create node 1
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
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
