// CAKeyframeAnimation

import UIKit
import XCPlayground

let containerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 375.0, height: 667.0))

containerView.backgroundColor = UIColor.whiteColor()

var rectangle = UIView(frame: CGRect(x: 100.0, y: 100.0, width: 100, height: 50))
rectangle.backgroundColor = UIColor.whiteColor()
rectangle.layer.borderColor = UIColor.grayColor().CGColor
rectangle.layer.borderWidth = 1.0
containerView.addSubview(rectangle)

var animation:CAKeyframeAnimation = CAKeyframeAnimation(keyPath: "position.x")
// which positions the form should have
animation.values = [0, 10,-10, 10, 0]
// which point in time the keyframes occur. They are specified as fractions of the total duration of the keyframe animation.
animation.keyTimes = [0, 1/60, 3/60, 5/60, 1]
animation.duration = 0.4
// Core Animation to add the values specified by the animation to the value of the current render tree. This allows us to reuse the same animation for all form elements that need updating without having to know their positions in advance
animation.additive = true

rectangle.layer.addAnimation(animation, forKey: "shake")

XCPlaygroundPage.currentPage.liveView = containerView
