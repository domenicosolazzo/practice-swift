import UIKit
import XCPlayground

let containerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 500, height: 667.0))

containerView.backgroundColor = UIColor.whiteColor()

var rectangle = UIView(frame: CGRect(x: 0, y: 300.0, width: 30, height: 30))
rectangle.backgroundColor = UIColor.yellowColor()
rectangle.layer.borderWidth = 1.0
rectangle.layer.borderColor = UIColor.darkGrayColor().CGColor
containerView.addSubview(rectangle)

// CABasicAnimation
var animation = CABasicAnimation()
animation.keyPath = "position.x"
animation.fromValue = 77
animation.toValue = 455
animation.duration = 1

rectangle.layer.addAnimation(animation, forKey: "moveX")
rectangle.layer.position = CGPointMake(455, 300)


XCPlaygroundPage.currentPage.liveView = containerView

