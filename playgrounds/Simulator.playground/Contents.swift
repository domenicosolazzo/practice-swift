// CAMediaTiming

import UIKit

struct MainScene {
    let vc: UIViewController
    let nc: UINavigationController
    init(vc: UIViewController) {
        self.vc = vc
        self.nc = UINavigationController(rootViewController: vc)
    }
}

extension UIViewController {
    class func viewController(color: UIColor) -> UIViewController {
        let vc = UIViewController()
        vc.view = UIView(frame: UIScreen.main.bounds)
        vc.view.backgroundColor = color
        return vc
    }
}

@objc protocol DataRetrievalOperations {
    @objc optional func buttonPressed(sender: UIButton)
    
}

class ButtonHandler: NSObject, DataRetrievalOperations {
    let scene: MainScene
    init(scene: MainScene) {
        self.scene = scene
        super.init()
    }
    
    func buttonPressed(sender:UIButton) {
        print("button pressed")
        let vc = UIViewController.viewController(color: UIColor.yellow)
        self.scene.nc.pushViewController(vc, animated: true)
    }
}



let vc = UIViewController.viewController(color: UIColor.green)
vc.title = "title"

let button = UIButton(type: .system) as UIButton
button.setTitle("press me", for: UIControlState.normal)
button.sizeToFit()
button.center = vc.view.center
vc.view.addSubview(button)

let mainScene = MainScene(vc: vc)

let handler = ButtonHandler(scene: mainScene)
button.addTarget(handler, action: #selector(handler.buttonPressed(sender:_)), for: UIControlEvents.touchUpInside)


//Run playground
let window = UIWindow(frame: UIScreen.main.bounds)
window.rootViewController = mainScene.nc
window.makeKeyAndVisible()
CFRunLoopRun()
