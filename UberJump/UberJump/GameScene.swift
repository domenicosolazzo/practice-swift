//
//  GameScene.swift
//  UberJump
//
//  Created by Domenico Solazzo on 9/20/14.
//  Copyright (c) 2014 Domenico Solazzo. All rights reserved.
//

import SpriteKit
import CoreMotion

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
    var _motionManager = CMMotionManager()
    // Acceleration value from accelerometer
    var _xAcceleration:CGFloat = 0
    // Max y reached by player
    var _maxPlayerY:Int?
    
    // Labels
    var _lblScore:SKLabelNode?
    var _lblStars:SKLabelNode?

    
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
        
        /// Reset
        self._maxPlayerY = 80
        
        /// Contact delegate
        self.physicsWorld.contactDelegate = self
        
        // Motion manager
        _motionManager = CMMotionManager()
        
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
        
        /// Hud node
        _hudNode = self.createHud()
        self.addChild(_hudNode!)
        
        
        //accelerometerUpdateInterval defines the number of seconds between updates from the accelerometer. A value of 0.2 produces a smooth update rate for accelerometer changes.
        _motionManager.accelerometerUpdateInterval = 0.2;
        
        _motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.currentQueue(), withHandler: {
            (data, error) in
            var accelerometerData:CMAccelerometerData = data as CMAccelerometerData
            var acceleration:CMAcceleration = accelerometerData.acceleration
            /// you’ll get much smoother movement using a value derived from three quarters of the accelerometer’s x-axis acceleration (say that three times fast!) and one quarter of the current x-axis acceleration.
            self._xAcceleration = (CGFloat(acceleration.x) * CGFloat(0.75)) + (self._xAcceleration * CGFloat(0.25))
            
        })
        
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
        
        // Build the HUD
        
        // Stars
        var star:SKSpriteNode = SKSpriteNode(imageNamed: "Star")
        star.position = CGPointMake(25, self.size.height-30);
        hudNode.addChild(star)
        
        // 2
        _lblStars = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
        _lblStars?.fontSize = 30;
        _lblStars?.fontColor = SKColor.whiteColor()
        _lblStars?.position = CGPointMake(50, self.size.height-40);
        _lblStars?.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        
        _lblStars?.text = NSString(format: "X %d", GameState.sharedInstance._stars)
        hudNode.addChild(_lblStars!)
        
        // Score
        _lblScore = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
        _lblScore?.fontSize = 30;
        _lblScore?.fontColor = SKColor.whiteColor()
        _lblScore?.position = CGPointMake(self.size.width-20, self.size.height-40);
        _lblScore?.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Right;
        _lblScore?.text = "0"
        hudNode.addChild(_lblScore!)
        
        
        return hudNode
    }
   
    override func didSimulatePhysics() {
        // Set velocity based on x-axis acceleration
        _playerNode?.physicsBody?.velocity = CGVectorMake(_xAcceleration * CGFloat(400.0), _playerNode!.physicsBody!.velocity.dy);
        
        // 2
        // Check x bounds
        if (_playerNode?.position.x < -CGFloat(20.0)) {
            _playerNode?.position = CGPointMake(CGFloat(340.0), _playerNode!.position.y)
        } else if (_playerNode?.position.x > CGFloat(340.0)) {
            _playerNode?.position = CGPointMake(-CGFloat(20.0), _playerNode!.position.y);
        }
        return;
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
            _lblStars?.text = NSString(format: "X %d", GameState.sharedInstance._stars)
            _lblScore?.text = NSString(format: "%d", GameState.sharedInstance._score)
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
        
        // New max height
        if Int(self._playerNode!.position.y) > _maxPlayerY! {
            GameState.sharedInstance._score += (Int(self._playerNode!.position.y) - _maxPlayerY!)
        
            _maxPlayerY = Int(self._playerNode!.position.y)
        
            self._lblScore?.text = NSString(format: "%d", GameState.sharedInstance._score )
        }
    }
}
