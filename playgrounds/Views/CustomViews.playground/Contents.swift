//: Custom Views
import UIKit
import XCPlayground

class CustomViewController: UIViewController{

}

var customViewController = CustomViewController.init(nibName: nil, bundle: nil)
customViewController.view.backgroundColor = UIColor.blueColor()
var label = UILabel(frame: CGRect(x: 100, y: 50, width: 100, height: 50))
label.text = "Hello world"
customViewController.view.addSubview(label)

// Set the current live view to the newly create custom view
XCPlaygroundPage.currentPage.liveView = customViewController