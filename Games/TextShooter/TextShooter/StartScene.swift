//
//  StartScene.swift
//  TextShooter
//
//  Created by Domenico on 01/05/15.
//  Copyright (c) 2015 Domenico. All rights reserved.
//

import UIKit
import SpriteKit

class StartScene: SKScene {
    override init(size: CGSize) {
        super.init(size: size)
        backgroundColor = SKColor.green
        
        let topLabel = SKLabelNode(fontNamed: "Courier")
        topLabel.text = "TextShooter"
        topLabel.fontColor = SKColor.black
        topLabel.fontSize = 48
        topLabel.position = CGPoint(x: frame.size.width/2,
            y: frame.size.height * 0.7)
        addChild(topLabel)
        
        let bottomLabel = SKLabelNode(fontNamed: "Courier")
        bottomLabel.text = "Touch anywhere to start"
        bottomLabel.fontColor = SKColor.black
        bottomLabel.fontSize = 20
        bottomLabel.position = CGPoint(x: frame.size.width/2,
            y: frame.size.height * 0.3)
        addChild(bottomLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func touchesBegan(_ touches: Set<NSObject>,
        with event: UIEvent) {
            let transition = SKTransition.doorway(withDuration: 1.0)
            let game = GameScene(size:frame.size)
            view!.presentScene(game, transition: transition)
    }
}
