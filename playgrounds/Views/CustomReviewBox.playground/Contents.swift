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
        var v = self.createReviewBox()
        //self.view.addSubview(v)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createReviewBox() -> UIView{
        var view = UIView(frame: CGRectZero)
        
        view.backgroundColor = UIColor.blueColor()
        self.view.addSubview(view)
        /*var label = UILabel(frame: CGRectZero)
        
        label.tintColor = UIColor.blueColor()
        label.text = "Did you like it?"
        view.addSubview(label)**/
        
        
        /**
        
        var button2 = UIButton(frame: CGRect(x: 100, y: 50, width: 50, height: 50))
        button2.setTitle("OK", forState: UIControlState.Normal)
        button2.backgroundColor = UIColor.blueColor()
        view.addSubview(button2)
        
        var button1 = UIButton(frame: CGRect(x: 0, y: 50, width: 50, height: 50))
        button1.setTitle("Nah", forState: UIControlState.Normal)
        button1.backgroundColor = UIColor.blueColor()
        view.addSubview(button1)
        
        **/
        var metrics = ["viewWidth":self.view.frame.size.width]
        var views = ["myView":view, "superview": self.view]
        var constraints = NSLayoutConstraint.constraintsWithVisualFormat("[superview]-[myView(viewWidth)]", options: [NSLayoutFormatOptions.AlignAllCenterY], metrics: metrics, views: views)
        constraints += NSLayoutConstraint.constraintsWithVisualFormat("V:[topGuide]-[myView(160)]", options: [NSLayoutFormatOptions.AlignAllCenterX], metrics: metrics, views: ["myView":view, "superview": self.view, "topGuide":self.topLayoutGuide])
        
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activateConstraints(constraints)
        
        return view
    }
    
    
    
}

var customViewController = CustomViewController.init(nibName: nil, bundle: nil)

customViewController.view.backgroundColor = UIColor.whiteColor()

// Set the current live view to the newly create custom view
XCPlaygroundPage.currentPage.liveView = customViewController
