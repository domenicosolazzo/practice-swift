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
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialization()
    }
    
    func initialization(){
        self.backgroundColor = SKColor.whiteColor()
    }
    override func didMoveToView(view: SKView) {
        
    }
    
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
