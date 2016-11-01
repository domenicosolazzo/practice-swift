//
//  GameOverScene.swift
//  TextShooter
//
//  Created by Domenico on 01/05/15.
//  Copyright (c) 2015 Domenico. All rights reserved.
//

import UIKit
import SpriteKit

class GameOverScene: SKScene {
    
    override init(size: CGSize) {
        super.init(size: size)
        backgroundColor = SKColor.purple
        let text = SKLabelNode(fontNamed: "Courier")
        text.text = "Game Over"
        text.fontColor = SKColor.white
        text.fontSize = 50
        text.position = CGPoint(x: frame.size.width/2, y: frame.size.height/2)
        addChild(text)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func didMove(to view: SKView) {
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(3 * Int64(NSEC_PER_SEC)) / Double(NSEC_PER_SEC)) {
                let transition = SKTransition.flipVertical(withDuration: 1)
                let start = StartScene(size: self.frame.size)
                view.presentScene(start, transition: transition)
        }
    }
}
