//
//  GameScene.swift
//  TextShooter
//
//  Created by Domenico on 01/05/15.
//  Copyright (c) 2015 Domenico. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    private var levelNumber: UInt
    private var playerLives: Int
    private var finished = false
    private let playerNode: PlayerNode = PlayerNode()
    private let enemies =  SKNode()
    private let playerBullets = SKNode()
    
    class func scene(size:CGSize, levelNumber:UInt) -> GameScene {
        return GameScene(size: size, levelNumber: levelNumber)
    }
    
    override convenience init(size:CGSize) {
        self.init(size: size, levelNumber: 1)
    }
    
    init(size:CGSize, levelNumber:UInt) {
        self.levelNumber = levelNumber
        self.playerLives = 5
        super.init(size: size)
        
        backgroundColor = SKColor.whiteColor()
        
        let lives = SKLabelNode(fontNamed: "Courier")
        lives.fontSize = 16
        lives.fontColor = SKColor.blackColor()
        lives.name = "LivesLabel"
        lives.text = "Lives: \(playerLives)"
        lives.verticalAlignmentMode = .Top
        lives.horizontalAlignmentMode = .Right
        lives.position = CGPointMake(frame.size.width,
            frame.size.height)
        addChild(lives)
        
        let level = SKLabelNode(fontNamed: "Courier")
        level.fontSize = 16
        level.fontColor = SKColor.blackColor()
        level.name = "LevelLabel"
        level.text = "Level \(levelNumber)"
        level.verticalAlignmentMode = .Top
        level.horizontalAlignmentMode = .Left
        level.position = CGPointMake(0, frame.height)
        addChild(level)
        
        // Create a new player
        playerNode.position = CGPointMake(CGRectGetMidX(frame), CGRectGetHeight(frame) * 0.1)
        addChild(playerNode)
        
        // Enemies
        addChild(enemies)
        spawnEnemies()
        
        // Player bullets
        addChild(playerBullets)
        
        // Physics body delegate
        physicsWorld.gravity = CGVectorMake(0, -1)
        physicsWorld.contactDelegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        levelNumber = UInt(aDecoder.decodeIntegerForKey("level"))
        playerLives = aDecoder.decodeIntegerForKey("playerLives")
        super.init(coder: aDecoder)
    }
    
    override func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeInteger(Int(levelNumber), forKey: "level")
        aCoder.encodeInteger(playerLives, forKey: "playerLives")
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            if location.y < CGRectGetHeight(frame) * 0.2 {
                let target = CGPointMake(location.x, playerNode.position.y)
                playerNode.moveToward(target)
            } else {
                let bullet =
                BulletNode.bullet(from: playerNode.position, toward: location)
                playerBullets.addChild(bullet)
            }
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        if finished {
            return
        }
        updateBullets()
        updateEnemies()
        checkForNextLevel()
    }
    
    private func updateBullets() {
        var bulletsToRemove:[BulletNode] = []
        for bullet in playerBullets.children as! [BulletNode] {
            // Remove any bullets that have moved off-screen
            if !CGRectContainsPoint(frame, bullet.position) {
                // Mark bullet for removal
                bulletsToRemove.append(bullet)
                continue
            }
            
            // Apply thrust to remaining bullets
            bullet.applyRecurringForce()
        }
        
        playerBullets.removeChildrenInArray(bulletsToRemove)
    }
    
    private func updateEnemies() {
        var enemiesToRemove:[EnemyNode] = []
        for node in enemies.children as! [EnemyNode] {
            if !CGRectContainsPoint(frame, node.position) {
                // Mark enemy for removal
                enemiesToRemove.append(node)
                continue
            }
        }
        
        enemies.removeChildrenInArray(enemiesToRemove)
    }
    
    // Spawn a sequence of enemies
    private func spawnEnemies() {
        let count = UInt(log(Float(levelNumber))) + levelNumber
        for var i: UInt = 0; i < count; i++ {
            let enemy = EnemyNode()
            let size = frame.size;
            let x = arc4random_uniform(UInt32(size.width * 0.8))
                + UInt32(size.width * 0.1)
            let y = arc4random_uniform(UInt32(size.height * 0.5))
                + UInt32(size.height * 0.5)
            enemy.position = CGPointMake(CGFloat(x), CGFloat(y))
            enemies.addChild(enemy)
        }
    }
    
    private func checkForNextLevel() {
        if enemies.children.isEmpty {
            goToNextLevel()
        }
    }
    
    private func goToNextLevel() {
        finished = true
        
        let label = SKLabelNode(fontNamed: "Courier")
        label.text = "Level Complete!"
        label.fontColor = SKColor.blueColor()
        label.fontSize = 32
        label.position = CGPointMake(frame.size.width * 0.5,
            frame.size.height * 0.5)
        addChild(label)
        
        let nextLevel = GameScene(size: frame.size, levelNumber: levelNumber + 1)
        nextLevel.playerLives = playerLives
        view!.presentScene(nextLevel, transition:
            SKTransition.flipHorizontalWithDuration(1.0))
    }
    
    //- MARK: SKPhysicsBodyContactDelegate
    func didBeginContact(contact: SKPhysicsContact) {
        if contact.bodyA.categoryBitMask == contact.bodyB.categoryBitMask {
            // Both bodies are in the same category
            let nodeA = contact.bodyA.node!
            let nodeB = contact.bodyB.node!
            nodeA.friendlyBumpFrom(nodeB)
            nodeB.friendlyBumpFrom(nodeA)
        } else {
            var attacker: SKNode
            var attackee: SKNode
            
            if contact.bodyA.categoryBitMask
                > contact.bodyB.categoryBitMask {
                    // Body A is attacking Body B
                    attacker = contact.bodyA.node!
                    attackee = contact.bodyB.node!
            } else {
                // Body B is attacking Body A
                attacker = contact.bodyB.node!
                attackee = contact.bodyA.node!
            }
            
            if attackee is PlayerNode {
                playerLives--
            }
            attackee.receiveAttacker(attacker, contact: contact)
            playerBullets.removeChildrenInArray([attacker])
            enemies.removeChildrenInArray([attacker])
        }
    }
    
    
}
