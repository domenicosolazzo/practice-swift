//: Playground - noun: a place where people can play

import UIKit
import XCPlayground

let containerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 375.0, height: 667.0))

containerView.backgroundColor = UIColor.whiteColor()

var rectangle = UIView(frame: CGRect(x: 300.0, y: 300.0, width: 80, height: 50))
rectangle.backgroundColor = UIColor.yellowColor()
rectangle.layer.borderWidth = 1.0
rectangle.layer.borderColor = UIColor.darkGrayColor().CGColor
containerView.addSubview(rectangle)

//Transform
var translate = CGAffineTransformMakeTranslation(100.0, 50.0)
var scale = CGAffineTransformMakeScale(2.0, 2.0)
var combine = CGAffineTransformConcat(translate, scale)

let rotate = CGAffineTransformMakeRotation(3.14)
combine = CGAffineTransformConcat(combine, rotate)


UIView.animateWithDuration(2) {
    rectangle.transform =  combine
}







XCPlaygroundPage.currentPage.liveView = containerView
