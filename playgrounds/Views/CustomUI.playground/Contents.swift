//: Custom Views
import UIKit
import XCPlayground

class CustomViewController: UIViewController{
    @IBOutlet var label:UILabel?{
        didSet{
            self.view.addSubview(self.label!)
            var constraints = NSLayoutConstraint.constraintsWithVisualFormat("|-(>=20)-[myLabel(==200)]-(>=20)-|", options: [NSLayoutFormatOptions.AlignAllCenterX,NSLayoutFormatOptions.AlignAllCenterY], metrics: nil, views: ["myLabel":self.label!])
            var constraints2 = NSLayoutConstraint.constraintsWithVisualFormat("V:|-[myLabel]-|", options: [NSLayoutFormatOptions.AlignAllCenterY], metrics: nil, views: ["myLabel":self.label!])
            constraints.appendContentsOf(constraints2)
            
            self.label?.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activateConstraints(constraints)
            
        }
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}

var customViewController = CustomViewController.init(nibName: nil, bundle: nil)
var label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
label.text = "Test"

customViewController.view.backgroundColor = UIColor.whiteColor()
customViewController.label = label

// Set the current live view to the newly create custom view
XCPlaygroundPage.currentPage.liveView = customViewController