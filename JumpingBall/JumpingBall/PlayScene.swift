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
        
        // Block1 position: it should be outside of the screen in the beginning
        self.block1.position = CGPointMake(CGRectGetMaxX(self.frame) + self.block1.size.width, self.heroBaseLine)
        // Block1 position: it should be outside of the screen in the beginning
        self.block2.position = CGPointMake(CGRectGetMaxX(self.frame) + self.block2.size.width, self.heroBaseLine + self.block2.size.height)
        
        // Present the running bar in the screen
        self.addChild(self.runningBar)
        // Present the hero in the screen
        self.addChild(self.hero)
        
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
        
        
    }
}
