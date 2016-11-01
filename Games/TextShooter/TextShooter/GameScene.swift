//
//  GameScene.swift
//  TextShooter
//
//  Created by Domenico on 01/05/15.
//  Copyright (c) 2015 Domenico. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    fileprivate var levelNumber: UInt
    fileprivate var playerLives: Int {
        didSet {
            let lives = childNode(withName: "LivesLabel") as! SKLabelNode
            lives.text = "Lives: \(playerLives)"
        }
    }
    fileprivate var finished = false
    fileprivate let playerNode: PlayerNode = PlayerNode()
    fileprivate let enemies =  SKNode()
    fileprivate let playerBullets = SKNode()
    fileprivate let forceFields = SKNode()
    
    class func scene(_ size:CGSize, levelNumber:UInt) -> GameScene {
        return GameScene(size: size, levelNumber: levelNumber)
    }
    
    override convenience init(size:CGSize) {
        self.init(size: size, levelNumber: 1)
    }
    
    init(size:CGSize, levelNumber:UInt) {
        self.levelNumber = levelNumber
        self.playerLives = 5
        super.init(size: size)
        
        backgroundColor = SKColor.white
        
        let lives = SKLabelNode(fontNamed: "Courier")
        lives.fontSize = 16
        lives.fontColor = SKColor.black
        lives.name = "LivesLabel"
        lives.text = "Lives: \(playerLives)"
        lives.verticalAlignmentMode = .top
        lives.horizontalAlignmentMode = .right
        lives.position = CGPoint(x: frame.size.width,
            y: frame.size.height)
        addChild(lives)
        
        let level = SKLabelNode(fontNamed: "Courier")
        level.fontSize = 16
        level.fontColor = SKColor.black
        level.name = "LevelLabel"
        level.text = "Level \(levelNumber)"
        level.verticalAlignmentMode = .top
        level.horizontalAlignmentMode = .left
        level.position = CGPoint(x: 0, y: frame.height)
        addChild(level)
        
        // Create a new player
        playerNode.position = CGPoint(x: frame.midX, y: frame.height * 0.1)
        addChild(playerNode)
        
        // Enemies
        addChild(enemies)
        spawnEnemies()
        
        // Player bullets
        addChild(playerBullets)
        
        // Force Fields
        addChild(forceFields)
        createForceFields()
        
        // Physics body delegate
        physicsWorld.gravity = CGVector(dx: 0, dy: -1)
        physicsWorld.contactDelegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        levelNumber = UInt(aDecoder.decodeInteger(forKey: "level"))
        playerLives = aDecoder.decodeInteger(forKey: "playerLives")
        super.init(coder: aDecoder)
    }
    
    override func encode(with aCoder: NSCoder) {
        aCoder.encode(Int(levelNumber), forKey: "level")
        aCoder.encode(playerLives, forKey: "playerLives")
    }
    
    override func touchesBegan(_ touches: Set<NSObject>, with event: UIEvent) {
        /* Called when a touch begins */
        for touch: AnyObject in touches {
            let location = touch.location(in: self)
            if location.y < frame.height * 0.2 {
                let target = CGPoint(x: location.x, y: playerNode.position.y)
                playerNode.moveToward(target)
            } else {
                let bullet =
                BulletNode.bullet(from: playerNode.position, toward: location)
                playerBullets.addChild(bullet)
            }
        }
    }
   
    override func update(_ currentTime: TimeInterval) {
        if finished {
            return
        }
        updateBullets()
        updateEnemies()
        checkForNextLevel()
        
        if (!checkForGameOver()) {
            checkForNextLevel()
        }
    }
    
    fileprivate func updateBullets() {
        var bulletsToRemove:[BulletNode] = []
        for bullet in playerBullets.children as! [BulletNode] {
            // Remove any bullets that have moved off-screen
            if !frame.contains(bullet.position) {
                // Mark bullet for removal
                bulletsToRemove.append(bullet)
                continue
            }
            
            // Apply thrust to remaining bullets
            bullet.applyRecurringForce()
        }
        
        playerBullets.removeChildren(in: bulletsToRemove)
    }
    
    fileprivate func updateEnemies() {
        var enemiesToRemove:[EnemyNode] = []
        for node in enemies.children as! [EnemyNode] {
            if !frame.contains(node.position) {
                // Mark enemy for removal
                enemiesToRemove.append(node)
                continue
            }
        }
        
        enemies.removeChildren(in: enemiesToRemove)
    }
    
    // Spawn a sequence of enemies
    fileprivate func spawnEnemies() {
        let count = UInt(log(Float(levelNumber))) + levelNumber
        for i: UInt in 0 ..< count {
            let enemy = EnemyNode()
            let size = frame.size;
            let x = arc4random_uniform(UInt32(size.width * 0.8))
                + UInt32(size.width * 0.1)
            let y = arc4random_uniform(UInt32(size.height * 0.5))
                + UInt32(size.height * 0.5)
            enemy.position = CGPoint(x: CGFloat(x), y: CGFloat(y))
            enemies.addChild(enemy)
        }
    }
    
    fileprivate func checkForNextLevel() {
        if enemies.children.isEmpty {
            goToNextLevel()
        }
    }
    
    fileprivate func goToNextLevel() {
        finished = true
        
        let label = SKLabelNode(fontNamed: "Courier")
        label.text = "Level Complete!"
        label.fontColor = SKColor.blue
        label.fontSize = 32
        label.position = CGPoint(x: frame.size.width * 0.5,
            y: frame.size.height * 0.5)
        addChild(label)
        
        let nextLevel = GameScene(size: frame.size, levelNumber: levelNumber + 1)
        nextLevel.playerLives = playerLives
        view!.presentScene(nextLevel, transition:
            SKTransition.flipHorizontal(withDuration: 1.0))
    }
    
    //- MARK: SKPhysicsBodyContactDelegate
    func didBegin(_ contact: SKPhysicsContact) {
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
                playerLives -= 1
            }
            attackee.receiveAttacker(attacker, contact: contact)
            playerBullets.removeChildren(in: [attacker])
            enemies.removeChildren(in: [attacker])
        }
    }
    
    fileprivate func checkForGameOver() -> Bool {
        if playerLives == 0 {
            triggerGameOver()
            return true
        }
        return false
    }
    
    fileprivate func triggerGameOver() {
        finished = true
        
        let path = Bundle.main.path(forResource: "EnemyExplosion",
            ofType: "sks")
        let explosion = NSKeyedUnarchiver.unarchiveObject(withFile: path!)
            as! SKEmitterNode
        explosion.numParticlesToEmit = 200
        explosion.position = playerNode.position
        scene!.addChild(explosion)
        playerNode.removeFromParent()
        
        let transition = SKTransition.doorsOpenVertical(withDuration: 1)
        let gameOver = GameOverScene(size: frame.size)
        view!.presentScene(gameOver, transition: transition)
    }
    
    fileprivate func createForceFields() {
        let fieldCount = 3
        let size = frame.size
        let sectionWidth = Int(size.width)/fieldCount
        for i in 0 ..< fieldCount {
            
            let x = CGFloat(UInt32(i) * UInt32(sectionWidth) + arc4random_uniform(UInt32(sectionWidth)))
            let y = CGFloat(arc4random_uniform(UInt32(size.height * 0.25)) + UInt32(size.height * 0.25))
            
            let gravityField = SKFieldNode.radialGravityField()
            gravityField.position = CGPoint(x: x, y: y)
            gravityField.categoryBitMask = GravityFieldCategory
            gravityField.strength = 4
            gravityField.falloff = 2
            gravityField.region = SKRegion(size: CGSize(width: size.width * 0.3,
                height: size.height * 0.1))
            forceFields.addChild(gravityField)
            
            let fieldLocationNode = SKLabelNode(fontNamed: "Courier")
            fieldLocationNode.fontSize = 16
            fieldLocationNode.fontColor = SKColor.red
            fieldLocationNode.name = "GravityField"
            fieldLocationNode.text = "*"
            fieldLocationNode.position = CGPoint(x: x, y: y)
            forceFields.addChild(fieldLocationNode)
        }
    }
    
    
}
