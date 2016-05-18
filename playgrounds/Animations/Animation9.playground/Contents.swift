// CAMediaTimingFunction

import UIKit
import XCPlayground

let containerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 375.0, height: 667.0))
containerView.backgroundColor = UIColor.whiteColor()

var rectangle = UIView(frame: CGRect(x: 100, y: 100, width: 50, height: 50))
rectangle.backgroundColor = UIColor.yellowColor()
rectangle.layer.borderColor = UIColor.grayColor().CGColor
rectangle.layer.borderWidth = 1.0
containerView.addSubview(rectangle)

var rectangle2 = UIView(frame: CGRect(x: 100, y: 300, width: 50, height: 50))
rectangle2.backgroundColor = UIColor.blueColor()
rectangle2.layer.borderColor = UIColor.grayColor().CGColor
rectangle2.layer.borderWidth = 1.0
containerView.addSubview(rectangle2)

var animation = CABasicAnimation(keyPath: "position.z")
animation.fromValue = -1
animation.toValue = 1
animation.duration = 1.2

var rotation = CAKeyframeAnimation(keyPath:"transform.rotation")
rotation.values = [0, 0.14, 0]
rotation.duration = 1.2
rotation.timingFunctions = [
    CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut),
    CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
]


var position = CAKeyframeAnimation(keyPath: "position")

position.values = [
    NSValue(CGPoint: CGPointZero),
    NSValue(CGPoint: CGPointMake(110, -20)),
    NSValue(CGPoint: CGPointZero)
]

position.timingFunctions = [
    CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut),
    CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
]
position.additive = true;
position.duration = 1.2;

var group = CAAnimationGroup()
group.animations = [ animation, rotation, position ]
group.duration = 1.2;
group.beginTime = 0.5;

rectangle2.layer.addAnimation(group, forKey: "shuffle")

rectangle2.layer.zPosition = 1;

XCPlaygroundPage.currentPage.liveView = containerView
