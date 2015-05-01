//
//  EnemyNode.swift
//  TextShooter
//
//  Created by Domenico on 01/05/15.
//  Copyright (c) 2015 Domenico. All rights reserved.
//

import UIKit
import SpriteKit

class EnemyNode: SKNode {
    override init() {
        super.init()
        name = "Enemy \(self)"
        initNodeGraph()
        initPhysicsBody()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func initNodeGraph() {
        let topRow = SKLabelNode(fontNamed: "Courier-Bold")
        topRow.fontColor = SKColor.brownColor()
        topRow.fontSize = 20
        topRow.text = "x x"
        topRow.position = CGPointMake(0, 15)
        addChild(topRow)
        
        let middleRow = SKLabelNode(fontNamed: "Courier-Bold")
        middleRow.fontColor = SKColor.brownColor()
        middleRow.fontSize = 20
        middleRow.text = "x"
        addChild(middleRow)
        
        let bottomRow = SKLabelNode(fontNamed: "Courier-Bold")
        bottomRow.fontColor = SKColor.brownColor()
        bottomRow.fontSize = 20
        bottomRow.text = "x x"
        bottomRow.position = CGPointMake(0, -15)
        addChild(bottomRow)
    }
    
    private func initPhysicsBody() {
        let body = SKPhysicsBody(rectangleOfSize: CGSizeMake(40, 40))
        body.affectedByGravity = false
        body.categoryBitMask = EnemyCategory
        body.contactTestBitMask = PlayerCategory | EnemyCategory
        body.mass = 0.2
        body.angularDamping = 0
        body.linearDamping = 0
        physicsBody = body
    }
}
