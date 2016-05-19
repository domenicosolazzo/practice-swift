// CAMediaTiming

import UIKit
import XCPlayground
//XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

class Responder:NSObject{
    var myView:UIView!
    init(v:UIView){
        myView = v
    }
    func moveSlider(sender:UISlider){
        myView?.layer.timeOffset = Double(sender.value)
    }
}



let containerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 375.0, height: 667.0))
containerView.backgroundColor = UIColor.whiteColor()

var myView = UIView(frame: CGRect(x: 100, y: 10, width: 200, height: 50))
var responder = Responder(v: myView)
myView.backgroundColor = UIColor.orangeColor()
containerView.addSubview(myView)
var backgroundAnimation = CABasicAnimation(keyPath: "backgroundColor")
backgroundAnimation.fromValue = UIColor.orangeColor().CGColor
backgroundAnimation.toValue = UIColor.blueColor().CGColor
backgroundAnimation.duration = 1.0
myView.layer.addAnimation(backgroundAnimation, forKey: "background")

myView.layer.speed = 0.0

var slider = UISlider(frame: CGRect(x: 100, y: 100, width: 200, height: 10))
slider.addTarget(responder, action: Selector("Responder.moveSlider"), forControlEvents:UIControlEvents.TouchUpInside)
var slider2 = slider
containerView.addSubview(slider)



XCPlaygroundPage.currentPage.liveView = containerView
