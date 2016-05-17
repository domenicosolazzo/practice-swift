// CAMediaTimingFunction

import UIKit
import XCPlayground

let containerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 375.0, height: 667.0))
containerView.backgroundColor = UIColor.whiteColor()

var rectangle = UIView(frame: CGRect(x: 0, y: 50, width: 50, height: 50))
rectangle.backgroundColor = UIColor.yellowColor()
rectangle.layer.borderColor = UIColor.grayColor().CGColor
rectangle.layer.borderWidth = 1.0
containerView.addSubview(rectangle)

var animation = CABasicAnimation(keyPath: "position.x")
animation.fromValue = 50
animation.toValue = 350
animation.duration = 1

// Linear
animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
rectangle.layer.addAnimation(animation, forKey: "linear")


var rectangle2 = UIView(frame: CGRect(x: 0, y: 150, width: 50, height: 50))
rectangle2.backgroundColor = UIColor.yellowColor()
rectangle2.layer.borderColor = UIColor.grayColor().CGColor
rectangle2.layer.borderWidth = 1.0

containerView.addSubview(rectangle2)

animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
rectangle2.layer.addAnimation(animation, forKey: "easein")

var rectangle3 = UIView(frame: CGRect(x: 0, y: 250, width: 50, height: 50))
rectangle3.backgroundColor = UIColor.yellowColor()
rectangle3.layer.borderColor = UIColor.grayColor().CGColor
rectangle3.layer.borderWidth = 1.0

containerView.addSubview(rectangle3)
animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
rectangle3.layer.addAnimation(animation, forKey: "easeout")


var rectangle4 = UIView(frame: CGRect(x: 0, y: 350, width: 50, height: 50))
rectangle4.backgroundColor = UIColor.yellowColor()
rectangle4.layer.borderColor = UIColor.grayColor().CGColor
rectangle4.layer.borderWidth = 1.0

containerView.addSubview(rectangle4)
animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
rectangle4.layer.addAnimation(animation, forKey: "easein-easeout")


XCPlaygroundPage.currentPage.liveView = containerView
