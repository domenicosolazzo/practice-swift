import SpriteKit


class PlayScene: SKScene{
    // Sprite node for the bar
    let runningBar = SKSpriteNode(imageNamed: "bar")
    // Sprite node for the her
    let hero = SKSpriteNode(imageNamed: "hero")
    
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
        
        // Present the running bar in the screen
        self.addChild(self.runningBar)
        // Present the hero in the screen
        self.addChild(self.hero)
        
    }
    
    /// Update the scene: It will run every single frame
    override func update(currentTime: NSTimeInterval) {
        // Check if the runningBar X-Position is lower or equal to the maxBarX. In that case, you must reset 
        // to the original X-Position
        if self.runningBar.position.x <= self.maxBarX{
            self.runningBar.position.x = self.originRunningBarPositionX
        }
        
        
        // Rotation Degree
        var rotationDegree = CDouble(self.groundSpeed) * M_PI / 180
        // Rotate the hero
        self.hero.zRotation -= CGFloat(rotationDegree)
        
        // Change the X-Position of the running bar
        self.runningBar.position.x -= CGFloat(self.groundSpeed)
        
        
    }
}
