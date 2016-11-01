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
    
    fileprivate func initNodeGraph() {
        let topRow = SKLabelNode(fontNamed: "Courier-Bold")
        topRow.fontColor = SKColor.brown
        topRow.fontSize = 20
        topRow.text = "x x"
        topRow.position = CGPoint(x: 0, y: 15)
        addChild(topRow)
        
        let middleRow = SKLabelNode(fontNamed: "Courier-Bold")
        middleRow.fontColor = SKColor.brown
        middleRow.fontSize = 20
        middleRow.text = "x"
        addChild(middleRow)
        
        let bottomRow = SKLabelNode(fontNamed: "Courier-Bold")
        bottomRow.fontColor = SKColor.brown
        bottomRow.fontSize = 20
        bottomRow.text = "x x"
        bottomRow.position = CGPoint(x: 0, y: -15)
        addChild(bottomRow)
    }
    
    fileprivate func initPhysicsBody() {
        let body = SKPhysicsBody(rectangleOf: CGSize(width: 40, height: 40))
        body.affectedByGravity = false
        body.categoryBitMask = EnemyCategory
        body.contactTestBitMask = PlayerCategory | EnemyCategory
        body.mass = 0.2
        body.angularDamping = 0
        body.linearDamping = 0
        //Not affected from gravity
        body.fieldBitMask = 0
        physicsBody = body
    }
    
    //- MARK: SKNode extensions
    override func friendlyBumpFrom(_ node: SKNode) {
        physicsBody!.affectedByGravity = true
    }
    
    override func receiveAttacker(_ attacker: SKNode,
        contact: SKPhysicsContact) {
            physicsBody!.affectedByGravity = true
            let force = vectorMultiply(attacker.physicsBody!.velocity,
                contact.collisionImpulse)
            let myContact =
            scene!.convert(contact.contactPoint, to: self)
            physicsBody!.applyForce(force, atPoint: myContact)
            
            // Enemy explosion
            let path = Bundle.main.path(forResource: "MissileExplosion",
                ofType: "sks")
            let explosion = NSKeyedUnarchiver.unarchiveObject(withFile: path!)
                as! SKEmitterNode
            explosion.numParticlesToEmit = 20
            explosion.position = contact.contactPoint
            scene!.addChild(explosion)
    }
}
