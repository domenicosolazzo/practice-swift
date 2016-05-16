// CAKeyframeAnimation

import UIKit
import XCPlayground

let containerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 375.0, height: 667.0))

containerView.backgroundColor = UIColor.whiteColor()

var rectangle = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
rectangle.layer.cornerRadius = 50.0
rectangle.backgroundColor = UIColor.yellowColor()
rectangle.layer.borderColor = UIColor.grayColor().CGColor
rectangle.layer.borderWidth = 1.0
containerView.addSubview(rectangle)

var satellite = UIView(frame: CGRect(x: 20, y: 20, width: 20, height: 20))
satellite.backgroundColor = UIColor.grayColor()
containerView.addSubview(satellite)

var orbit:CAKeyframeAnimation = CAKeyframeAnimation(keyPath: "position")
orbit.path = CGPathCreateWithEllipseInRect(CGRect(x: 50, y: 50, width: 150, height: 150), nil)
orbit.duration = 4
orbit.additive = true
orbit.repeatCount = 4
orbit.calculationMode  = kCAAnimationPaced
orbit.rotationMode = kCAAnimationRotateAuto

satellite.layer.addAnimation(orbit, forKey: "orbit")


XCPlaygroundPage.currentPage.liveView = containerView
