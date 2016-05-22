//: Custom Views
import UIKit
import XCPlayground

class CustomViewController: UIViewController{
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        let tabBar = UITabBar(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        tabBar.add
        tabBar.barStyle = UIBarStyle.Default
        
        self.view.addSubview(tabBar)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

var customViewController = CustomViewController.init(nibName: nil, bundle: nil)
customViewController.view.backgroundColor = UIColor.whiteColor()

// Set the current live view to the newly create custom view
XCPlaygroundPage.currentPage.liveView = customViewController