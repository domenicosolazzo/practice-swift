import UIKit
import XCPlayground


class Abc{
    func testGesture(sender: AnyObject){
        
    }
}
let containerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 375.0, height: 667.0))

containerView.backgroundColor = UIColor.whiteColor()

var rectangle = UIView(frame: CGRect(x: 300.0, y: 300.0, width: 80, height: 50))
rectangle.backgroundColor = UIColor.yellowColor()
rectangle.layer.borderWidth = 1.0
rectangle.layer.borderColor = UIColor.darkGrayColor().CGColor
containerView.addSubview(rectangle)
var panGesture = UIPanGestureRecognizer(target: Abc(), action: #selector("Abc.testGesture"))

func testGesture(gestureRecognizer: UIPanGestureRecognizer){

}
XCPlaygroundPage.currentPage.liveView = containerView

