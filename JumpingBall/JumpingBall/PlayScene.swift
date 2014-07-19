import SpriteKit


class PlayScene: SKScene{
    // Sprite node for the bar
    let runningBar = SKSpriteNode(imageNamed: "bar")
    // Sprite node for the hero
    let hero = SKSpriteNode(imageNamed: "hero")
    // Sprite node for the block1
    let block1 = SKSpriteNode(imageNamed: "block1")
    // Sprite node for the block2
    let block2 = SKSpriteNode(imageNamed: "block2")
    
    // Original X position for the running bar
    var originRunningBarPositionX = CGFloat(0)
    // Amount of the hidden running bar that is available (The bar width is longer than the screen size)
    var maxBarX = CGFloat(0)
    // Ground speed
    var groundSpeed = 5
    // Baseline for the hero
    var heroBaseLine = CGFloat(0)
    // Check if the hero is on the ground
    var onGround = true
    // Velocity of the hero
    var velocityY = CGFloat(0)
    // Gravity
    var gravity = CGFloat(0.6)
    // BlockStatus dictionary
    var blockStatuses: Dictionary<String, BlockStatus> = [:]
    // Max X-Position for the Block
    var maxBlockX = CGFloat(0)
    // Original X-Positon for the blocks
    var originalBlockPositionX = CGFloat(0)
    // Score
    var score = 0
    // Score text
    var scoreText = SKLabelNode(fontNamed: "Chulkduster")
    // Collider type
    enum ColliderType{
        case hero = 1
        case block = 2
    }
    
    override func didMoveToView(view: SKView!) {
        self.backgroundColor = UIColor(hex: 0x809DFF)
        
        // Set the anchor point of the running bar at (0, 0.5)
        self.runningBar.anchorPoint = CGPointMake(0, 0.5)
        // Set the bar at the bottom of the screen
        self.runningBar.position = CGPointMake(
            CGRectGetMinX(self.frame),
            CGRectGetMinY(self.frame) + (self.runningBar.size.height / 2))
        
        // Set the original running bar X-position
        self.originRunningBarPositionX = self.runningBar.position.x
        
        // Set the MaxBarX ( RunningBar's widht - Screen's width)=> Available Running Bar
        self.maxBarX = self.runningBar.size.width - self.frame.width
        self.maxBarX *= -1 // Make a negative number
        
        // Set the baseline for the hero
        self.heroBaseLine = self.runningBar.position.y + (self.runningBar.size.height / 2) + (self.hero.size.width / 2)
        self.hero.position = CGPointMake(CGRectGetMinX(self.frame) + (self.hero.size.width) + (self.hero.size.width / 4), self.heroBaseLine)
        // Add a physic body for collision detection
        self.hero.physicsBody = SKPhysicsBody(circleOfRadius: self.hero.size.width/2))
        
        // Block1 position: it should be outside of the screen in the beginning
        self.block1.position = CGPointMake(CGRectGetMaxX(self.frame) + self.block1.size.width, self.heroBaseLine)
        self.block1.name = "block1"
        
        // Block1 position: it should be outside of the screen in the beginning
        self.block2.position = CGPointMake(CGRectGetMaxX(self.frame) + self.block2.size.width, self.heroBaseLine + self.block1.size.height / 2)
        // Set the name for block2
        self.block2.name = "block2"
        
        // Add block statuses for all the block
        blockStatuses["block1"] = BlockStatus(isRunning: false, timeGapForNextRun: random(), currentInterval: UInt32(0))
        blockStatuses["block2"] = BlockStatus(isRunning: false, timeGapForNextRun: random(), currentInterval: UInt32(0))
        
        // Initialize score text
        self.scoreText.text = "0"
        self.scoreText.fontSize = 42
        self.scoreText.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        
        // Set the max X-Position for the block
        self.maxBlockX = 0 - self.block1.size.width / 2
        
        // Set the original block position
        self.originalBlockPositionX = self.block1.position.x
        
        // Present the running bar in the screen
        self.addChild(self.runningBar)
        // Present the hero in the screen
        self.addChild(self.hero)
        // Present both block1 and block2 in the screen
        self.addChild(self.block1)
        self.addChild(self.block2)
        // Present scoreText
        self.addChild(self.scoreText)
        
    }
    
    func random() -> UInt32{
        // We want these blocks to come in a gap between 50 frame updates to 200 frame updates
        var range = UInt32(50)...UInt32(200)
        return range.startIndex + arc4random_uniform(range.endIndex - range.startIndex + 1)
    }
    
    // When the user hold down...
    override func touchesEnded(touches: NSSet!, withEvent event: UIEvent!) {
        if self.velocityY < 9.0{
            self.velocityY = 9.0
        }
    }
    
    override func touchesBegan(touches: NSSet!, withEvent event: UIEvent!) {
        // Check if the hero is on the ground
        if self.onGround{
            self.velocityY = -18.0
            self.onGround = false
        }
    }
    
    /// Update the scene: It will run every single frame
    override func update(currentTime: NSTimeInterval) {
        // Check if the runningBar X-Position is lower or equal to the maxBarX. In that case, you must reset 
        // to the original X-Position
        if self.runningBar.position.x <= self.maxBarX{
            self.runningBar.position.x = self.originRunningBarPositionX
        }
        
        // jump
        self.velocityY += self.gravity
        self.hero.position.y -= self.velocityY
        
        if self.hero.position.y < self.heroBaseLine{
            self.hero.position.y = self.heroBaseLine
            self.velocityY = 0.0
            self.onGround = true
        }
        
        // Rotation Degree
        var rotationDegree = CDouble(self.groundSpeed) * M_PI / 180
        // Rotate the hero
        self.hero.zRotation -= CGFloat(rotationDegree)
        
        // Change the X-Position of the running bar
        self.runningBar.position.x -= CGFloat(self.groundSpeed)
        
        // Run the blocks
        blockRunner()
    }
    
    func blockRunner() {
        for(block, blockStatus) in self.blockStatuses {
            // Take the current block by name
            var thisBlock = self.childNodeWithName(block)
            // Check if the block shoud run
            if blockStatus.shouldRunBlock() {
                // Add anew random time gap for the next run
                blockStatus.timeGapForNextRun = random()
                // Set the current interval to 0
                blockStatus.currentInterval = 0
                // Set the block as running
                blockStatus.isRunning = true
            }
            
            // Check if the block is running
            if blockStatus.isRunning {
                
                if thisBlock.position.x > self.maxBlockX {
                    thisBlock.position.x -= CGFloat(self.groundSpeed)
                }else {
                    // Set the position to the original X-position for the block
                    thisBlock.position.x = self.originalBlockPositionX
                    // The block is not running
                    blockStatus.isRunning = false
                    
                    // Update the score
                    self.score++
                    // If the score is a multiple of 5, increament the ground speed
                    if ((self.score % 5) == 0) {
                        self.groundSpeed++
                    }
                    // Update the scoreText
                    self.scoreText.text = String(self.score)
                }
            }else {
                // The block is not running and we will update its currentInterval
                blockStatus.currentInterval++
            }
        }
    }
}
