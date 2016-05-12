//: SPRING Animations


import UIKit
import XCPlayground

let containerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 375.0, height: 667.0))

containerView.backgroundColor = UIColor.whiteColor()

var rectangle = UIView(frame: CGRect(x: 300.0, y: 300.0, width: 80, height: 50))
rectangle.backgroundColor = UIColor.yellowColor()
rectangle.layer.borderWidth = 1.0
rectangle.layer.borderColor = UIColor.darkGrayColor().CGColor
containerView.addSubview(rectangle)

/**
 delay: how long it’ll wait before the animation starts.
 
 usingSpringWithDamping: the springiness of the bouncing animation. The higher the value, the less it’ll spring back. 0 will look like a ball and 1 will be smooth and linear.
 
 initialSpringVelocity: how strong it’ll start. The higher the value, the more push it’ll have at the beginning of the animation. 1 means Hulk and 0 means, well, sleepy Hulk.
 
 options: you just need to put nil all the time.
**/
UIView.animateWithDuration(duration, delay: delay, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: nil, animations: {
    rectangle.frame.origin = CGPoint
})

XCPlaygroundPage.currentPage.liveView = containerView

