//
//  GameScene.swift
//  UberJump
//
//  Created by Domenico Solazzo on 9/20/14.
//  Copyright (c) 2014 Domenico Solazzo. All rights reserved.
//

import SpriteKit

enum GameObjectType: UInt32{
    case Player = 1
    case Star = 2
    case Platform = 3
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    var _backgroundNode:SKNode?
    var _foregroundNode:SKNode?
    var _midgroundNode:SKNode?
    var _hudNode:SKNode?
    var _tapToStartNode:SKNode?
    var _playerNode:SKNode?
    // Height at which level ends
    var _endLevelY:Int?
    
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
        
        /// Contact delegate
        self.physicsWorld.contactDelegate = self
        
        /// Background Node
        _backgroundNode = self.createBackgroundNode()
        self.addChild(_backgroundNode!)
        
        
        /// Foreground Node
        _foregroundNode = SKNode()
        self.addChild(_foregroundNode!)
        
        /// Load the level
        var path = NSBundle.mainBundle().pathForResource("Level01", ofType: "plist")
        var levelData = NSDictionary(contentsOfFile: path!)
        
        // Height at which the player ends the level
        _endLevelY = levelData["EndY"] as Int
        
        // Add the platforms
        var platforms:NSDictionary = levelData["Platforms"] as NSDictionary
        var platformPatterns:NSDictionary = platforms["Patterns"] as NSDictionary
        var platformPositions:NSArray = platforms["Positions"] as NSArray
        for pp in platformPositions {
            var platformPosition = pp as NSDictionary
            var patternX:CGFloat = platformPosition["x"] as CGFloat
            var patternY:CGFloat = platformPosition["y"] as CGFloat
            var pattern:NSString = platformPosition["pattern"] as NSString
            
            // Look up the pattern
            var platformPattern = platformPatterns[pattern] as NSArray
            for platformP in platformPattern {
                var platformPoint = platformP as NSDictionary
                var x:CGFloat = platformPoint["x"] as CGFloat
                var y:CGFloat = platformPoint["y"] as CGFloat
                var type:Int = platformPoint["type"] as Int
                
                var platformNode:PlatformNode = self.createPlatformPosition(
                    CGPointMake(CGFloat(x + patternX), CGFloat(y + patternY)),
                    ofType: PlatformType.fromRaw(UInt32(type))!)
                _foregroundNode?.addChild(platformNode)
            }
        }
        
        // Add the stars
        var stars:NSDictionary = levelData["Stars"] as NSDictionary
        var starPatterns:NSDictionary = stars["Patterns"] as NSDictionary
        var starPositions:NSArray = stars["Positions"] as NSArray
        for starPosition in starPositions {
            var patternX:CGFloat = starPosition["x"] as CGFloat
            var patternY:CGFloat = starPosition["y"] as CGFloat
            var pattern:NSString = starPosition["pattern"] as NSString
            
            // Look up the pattern
            var starPattern:NSArray = starPatterns[pattern] as NSArray
            for starP in starPattern {
                var starPoint:NSDictionary = starP as NSDictionary
                var x:CGFloat = starPoint["x"] as CGFloat
                var y:CGFloat = starPoint["y"] as CGFloat
                var type = starPoint["type"] as Int
                
                var starNode:StarNode = self.createStarPosition(
                    CGPointMake(CGFloat(x + patternX), CGFloat(y + patternY)),
                    ofType:StarType.fromRaw(UInt32(type))!)
                _foregroundNode?.addChild(starNode)
            }
        }
        
        // Adding the midground
        _midgroundNode?.addChild(self.createMidgroundNode())
        
        /// Player node
        _playerNode = self.createPlayer()
        _foregroundNode?.addChild(_playerNode!)
        
        // Add star
        //var star = self.createStarPosition(CGPointMake(CGFloat(160), CGFloat(200)), ofType: StarType.STAR_SPECIAL)
        //_foregroundNode?.addChild(star)
        
        // Add platform
        //var platform = self.createPlatformPosition(CGPointMake(CGFloat(160), CGFloat(320)), ofType: PlatformType.PLATFORM_NORMAL)
        //_foregroundNode?.addChild(platform)
        
            
        /// Hud node
        _hudNode = self.createHud()
        self.addChild(_hudNode!)
        
        // Change gravity
        self.physicsWorld.gravity = CGVectorMake(CGFloat(0), CGFloat(-2))
    }
    
    func createStarPosition(position:CGPoint, ofType:StarType) -> StarNode{
        /// Instantiate your StarNode
        var node:StarNode = StarNode()
        
        /// Set the StarNode position
        node.position = position
        /// Set the StarNode name
        node.name = "NODE_STAR"
        
        // Assign the star’s graphic using an SKSpriteNode
        var sprite:SKSpriteNode = SKSpriteNode()
        if (ofType == StarType.STAR_NORMAL){
            sprite = SKSpriteNode(imageNamed: "Star")
        }else{
            sprite = SKSpriteNode(imageNamed: "StarSpecial")
        }
        /// Set the type
        node.starType = ofType
        node.addChild(sprite)
        
        // Circular physics body
        node.physicsBody = SKPhysicsBody(circleOfRadius: CGFloat(sprite.size.width/2))
        
        // The node is static
        node.physicsBody?.dynamic = false;
        
        // Collision detection
        node.physicsBody?.categoryBitMask = GameObjectType.Star.toRaw()
        node.physicsBody?.collisionBitMask = 0
        
        return node;
    }
    
    func createPlatformPosition(position:CGPoint, ofType:PlatformType) -> PlatformNode{
        /// Instantiate your PlatformNode
        var node:PlatformNode = PlatformNode()
        
        /// Set the StarNode position
        node.position = position
        /// Set the StarNode name
        node.name = "NODE_PLATFORM"
        
        // Assign the star’s graphic using an SKSpriteNode
        var sprite:SKSpriteNode = SKSpriteNode()
        if (ofType == PlatformType.PLATFORM_NORMAL){
            sprite = SKSpriteNode(imageNamed: "Platform")
        }else{
            sprite = SKSpriteNode(imageNamed: "PlatformBreak")
        }
        /// Set the type
        node.platformType = ofType
        node.addChild(sprite)
        
        // Circular physics body
        node.physicsBody = SKPhysicsBody(circleOfRadius: CGFloat(sprite.size.width/2))
        
        // The node is static
        node.physicsBody?.dynamic = false;
        
        // Collision detection
        node.physicsBody?.categoryBitMask = GameObjectType.Platform.toRaw()
        node.physicsBody?.collisionBitMask = 0
        
        return node;
    }
    
    func createMidgroundNode() -> SKNode{
        // Create the node
        var midgroundNode:SKNode = SKNode()
        
        // Add some branches to the midground
        for i in 0..<10 {
            var spriteName:NSString?
            
            var r = arc4random() % 2
            if (r > 0) {
                spriteName = "BranchRight"
            } else {
                spriteName = "BranchLeft"
            }
            var branchNode:SKSpriteNode = SKSpriteNode(imageNamed: spriteName!)
            branchNode.position = CGPointMake(CGFloat(160), CGFloat(500 * i))
            
            midgroundNode.addChild(branchNode)
        }
        
        // Return the completed background node
        return midgroundNode;
    }
    
    override func didMoveToView(view: SKView) {
        
    }

    /// Create a background node
    func createBackgroundNode() -> SKNode{
        
        var backgroundNode:SKNode = SKNode()
        
        for count in 0..<20{
            var backgroundImage = NSString(format:"Background%02d", count+1) as String
            var spriteNode:SKSpriteNode = SKSpriteNode(imageNamed: backgroundImage)
            spriteNode.anchorPoint = CGPointMake(CGFloat(0.5), CGFloat(0))
            spriteNode.position = CGPointMake(CGFloat(160), CGFloat(64 * count))
            
            
            backgroundNode.addChild(spriteNode)
            
        }
        return backgroundNode
    }
    
    /// Create a player
    func createPlayer() -> SKNode{
        var player: SKNode = SKNode()
        player.position = CGPointMake(CGFloat(160), CGFloat(64))
    
        var sprite = SKSpriteNode(imageNamed: "Player")
        
        /// Add physics
        player.physicsBody = SKPhysicsBody(circleOfRadius: CGFloat(sprite.size.width/2))
        /// Player is dynamic. It is false until the game starts
        player.physicsBody?.dynamic = false
        /// Player node to remain upright at all times
        player.physicsBody?.allowsRotation = false
        /// Physics body will not lose any of its momentum during collisions
        player.physicsBody?.restitution = CGFloat(1)
        /// No friction
        player.physicsBody?.friction = CGFloat(0)
        /// No linear damping
        player.physicsBody?.linearDamping = CGFloat(0)
        /// No angular damping
        player.physicsBody?.angularDamping = CGFloat(0)
        
        /// Collision detection
        player.physicsBody?.usesPreciseCollisionDetection = true
        player.physicsBody?.categoryBitMask = GameObjectType.Player.toRaw()
        /// Don’t want its physics engine to simulate any collisions for the player node.
        player.physicsBody?.collisionBitMask = 0
        player.physicsBody?.contactTestBitMask = GameObjectType.Star.toRaw() | GameObjectType.Platform.toRaw()
        
        /// Add sprite to the player node
        player.addChild(sprite)
        
        return player
    }
    
    func createHud() -> SKNode{
        var hudNode:SKNode = SKNode()
        _tapToStartNode = SKSpriteNode(imageNamed: "TapToStart")
        _tapToStartNode?.position = CGPointMake(CGFloat(160), CGFloat(180))
        
        hudNode.addChild(_tapToStartNode!)
        return hudNode
    }
   
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /// If we are already playing, ignore touches
        if(self._playerNode?.physicsBody?.dynamic == true){
            return
        }
        
        /// Remove the tap to start sign
        _tapToStartNode?.removeFromParent()
        
        // Start the player by putting them into the physics simulation
        _playerNode?.physicsBody?.dynamic = true;
        
        //You give the player node an initial upward impulse to get them started.
        _playerNode?.physicsBody?.applyImpulse(CGVectorMake(CGFloat(0), CGFloat(20)))
        
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        
        var updateHUD:Bool = false
        
        // Identify the GameObjectNode
        var other:SKNode = (contact.bodyA.node != _playerNode!) ? contact.bodyA.node! : contact.bodyB.node!;
        
        updateHUD = (other as GameObjectNode).collisionWithPlayer(_playerNode!)
        
        // Update the HUD if necessary
        if (updateHUD) {
            // 4 TODO: Update HUD in Part 2
        }
    }
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        // Calculate player y offset
        if (_playerNode?.position.y > CGFloat(200)) {
            _backgroundNode?.position = CGPointMake(CGFloat(0), -((_playerNode!.position.y - CGFloat(200))/10))
            _midgroundNode?.position = CGPointMake(CGFloat(0), -((_playerNode!.position.y - CGFloat(200)/4)))
            _foregroundNode?.position = CGPointMake(CGFloat(0), -(_playerNode!.position.y - CGFloat(200)))
        }
    }
}
