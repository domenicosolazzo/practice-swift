// CAMediaTimingFunction

import UIKit
import XCPlayground

let containerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 375.0, height: 667.0))
containerView.backgroundColor = UIColor.whiteColor()

var rectangle = UIView(frame: CGRect(x: 0, y: 50, width: 100, height: 100))
rectangle.backgroundColor = UIColor.yellowColor()
rectangle.layer.borderColor = UIColor.grayColor().CGColor
rectangle.layer.borderWidth = 1.0
containerView.addSubview(rectangle)

var animation = CABasicAnimation(keyPath: "position.x")
animation.fromValue = 50
animation.toValue = 300
animation.duration = 1

// Linear
animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
rectangle.layer.addAnimation(animation, forKey: "linear")

XCPlaygroundPage.currentPage.liveView = containerView
