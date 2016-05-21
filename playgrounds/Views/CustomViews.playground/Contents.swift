//: Custom Views
import UIKit
import XCPlayground

class CustomViewController: UIViewController{
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        let label = UILabel(frame: CGRect(x: 100, y: 50, width: 100, height: 50))
        
        label.text = "Hello world"
        self.view.addSubview(label)
        
        let button = UIButton(frame: CGRect(x: 200, y: 50, width: 100, height: 50))
        button.setTitle("Click me", forState: UIControlState.Normal)
        button.addTarget(self, action: #selector(test), forControlEvents: UIControlEvents.TouchUpInside)
        
        
        self.view.addSubview(button)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func test(){
        print("Hello World")
    }
}

var customViewController = CustomViewController.init(nibName: nil, bundle: nil)
customViewController.view.backgroundColor = UIColor.blueColor()
var label = UILabel(frame: CGRect(x: 100, y: 50, width: 100, height: 50))

// Set the current live view to the newly create custom view
XCPlaygroundPage.currentPage.liveView = customViewController
