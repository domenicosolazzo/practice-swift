//
//  PlayerNode.swift
//  TextShooter
//
//  Created by Domenico on 01/05/15.
//  Copyright (c) 2015 Domenico. All rights reserved.
//

import UIKit
import SpriteKit
import Foundation

class PlayerNode: SKNode {
    override init() {
        super.init()
        name = "Player \(self)"
        initNodeGraph()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func initNodeGraph() {
        let label = SKLabelNode(fontNamed: "Courier")
        label.fontColor = SKColor.darkGrayColor()
        label.fontSize = 40
        label.text = "v"
        label.zRotation = CGFloat(M_PI)
        label.name = "label"
        self.addChild(label)
    }
    
    func moveToward(location: CGPoint) {
        removeActionForKey("movement")
        removeActionForKey("wobbling")
        
        let distance = pointDistance(position, location)
        let screenWidth = UIScreen.mainScreen().bounds.size.width
        let duration = NSTimeInterval(2 * distance/screenWidth)
        
        runAction(SKAction.moveTo(location, duration: duration),
            withKey:"movement")
        
        // Wobble actions
        let wobbleTime = 0.3
        let halfWobbleTime = wobbleTime/2
        let wobbling = SKAction.sequence([
            SKAction.scaleXTo(0.2, duration: halfWobbleTime),
            SKAction.scaleXTo(1.0, duration: halfWobbleTime)
            ])
        let wobbleCount = Int(duration/wobbleTime)
        
        runAction(SKAction.repeatAction(wobbling, count: wobbleCount),
            withKey:"wobbling")
    }
}
