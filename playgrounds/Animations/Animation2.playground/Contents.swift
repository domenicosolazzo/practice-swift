//: Playground - noun: a place where people can play

import UIKit
import XCPlayground

let containerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 375.0, height: 667.0))

containerView.backgroundColor = UIColor.whiteColor()

var rectangle = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 50, height: 50))
rectangle.backgroundColor = UIColor.blackColor()
rectangle.layer.opacity = 0.0
containerView.addSubview(rectangle)



UIView.animateWithDuration(2, animations: {
    containerView.backgroundColor = UIColor.redColor()
    rectangle.frame.origin = CGPoint(x: 100.0, y: 100.0)
    rectangle.frame.size = CGSize(width: 100, height: 100)
    rectangle.layer.opacity = 1.0
    }) { (Bool) in
        UIView.animateWithDuration(2){
            rectangle.frame.origin = CGPoint(x: 0.0, y: 0.0)
            rectangle.frame.size = CGSize(width: 50, height: 50)
            rectangle.layer.opacity = 0.5
        }
    }


UIView.animateWithDuration(2) { 
    rectangle.layer.borderWidth = 2.0
    rectangle.layer.borderColor = UIColor.blueColor().CGColor
}

UIView.animateWithDuration(5) {
    rectangle.layer.shadowOpacity = 0.8
    rectangle.layer.shadowColor = UIColor.whiteColor().CGColor
    rectangle.layer.shadowRadius = 25.0
    rectangle.layer.shadowOffset = CGSize(width: 10.0, height: 10.0)
}

XCPlaygroundPage.currentPage.liveView = containerView
