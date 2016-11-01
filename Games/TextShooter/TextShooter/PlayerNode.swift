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
        initPhysicsBody()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    fileprivate func initNodeGraph() {
        let label = SKLabelNode(fontNamed: "Courier")
        label.fontColor = SKColor.darkGray
        label.fontSize = 40
        label.text = "v"
        label.zRotation = CGFloat(M_PI)
        label.name = "label"
        self.addChild(label)
    }
    
    func moveToward(_ location: CGPoint) {
        removeAction(forKey: "movement")
        removeAction(forKey: "wobbling")
        
        let distance = pointDistance(position, location)
        let screenWidth = UIScreen.main.bounds.size.width
        let duration = TimeInterval(2 * distance/screenWidth)
        
        runAction(SKAction.moveTo(location, duration: duration),
            withKey:"movement")
        
        // Wobble actions
        let wobbleTime = 0.3
        let halfWobbleTime = wobbleTime/2
        let wobbling = SKAction.sequence([
            SKAction.scaleX(to: 0.2, duration: halfWobbleTime),
            SKAction.scaleX(to: 1.0, duration: halfWobbleTime)
            ])
        let wobbleCount = Int(duration/wobbleTime)
        
        runAction(SKAction.repeatAction(wobbling, count: wobbleCount),
            withKey:"wobbling")
    }
    
    fileprivate func initPhysicsBody() {
        let body = SKPhysicsBody(rectangleOf: CGSize(width: 20, height: 20))
        body.affectedByGravity = false
        body.categoryBitMask = PlayerCategory
        body.contactTestBitMask = EnemyCategory
        body.collisionBitMask = 0
        // Not affected from gravity
        body.fieldBitMask = 0
        physicsBody = body
    }
    
    override func receiveAttacker(_ attacker: SKNode, contact: SKPhysicsContact) {
        let path = Bundle.main.path(forResource: "EnemyExplosion",
            ofType: "sks")
        let explosion = NSKeyedUnarchiver.unarchiveObject(withFile: path!)
            as! SKEmitterNode
        explosion.numParticlesToEmit = 50
        explosion.position = contact.contactPoint
        scene!.addChild(explosion)
    }
}
