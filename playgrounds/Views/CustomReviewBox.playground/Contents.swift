//: Custom Views
import UIKit
import XCPlayground

class CustomViewController: UIViewController{
    @IBOutlet var label:UILabel?{
        didSet{
            self.view.addSubview(self.label!)
            var constraints = NSLayoutConstraint.constraints(withVisualFormat: "|-(>=20)-[myLabel(==200)]-(>=20)-|", options: [NSLayoutFormatOptions.alignAllCenterX,NSLayoutFormatOptions.alignAllCenterY], metrics: nil, views: ["myLabel":self.label!])
            let constraints2 = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[myLabel]-|", options: [NSLayoutFormatOptions.alignAllCenterY], metrics: nil, views: ["myLabel":self.label!])
            constraints.append(contentsOf: constraints2)
            
            self.label?.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate(constraints)
            
        }
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        _ = self.createReviewBox()
        //self.view.addSubview(v)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createReviewBox() -> UIView{
        let view = UIView(frame: CGRect.zero )
        
        view.backgroundColor = UIColor.blue
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
        let metrics = ["viewWidth":self.view.frame.size.width]
        let views = ["myView":view, "superview": self.view]
        var constraints = NSLayoutConstraint.constraints(withVisualFormat: "[superview]-[myView(viewWidth)]", options: [NSLayoutFormatOptions.alignAllCenterY], metrics: metrics, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:[topGuide]-[myView(160)]", options: [NSLayoutFormatOptions.alignAllCenterX], metrics: metrics, views: ["myView":view, "superview": self.view, "topGuide":self.topLayoutGuide])
        
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(constraints)
        
        return view
    }
    
    
    
}

var customViewController = CustomViewController.init(nibName: nil, bundle: nil)

customViewController.view.backgroundColor = UIColor.white

// Set the current live view to the newly create custom view
XCPlaygroundPage.currentPage.liveView = customViewController
