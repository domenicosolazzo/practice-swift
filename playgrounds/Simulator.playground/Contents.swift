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
        vc.view = UIView(frame: UIScreen.mainScreen().bounds)
        vc.view.backgroundColor = color
        return vc
    }
}

class ButtonHandler: NSObject {
    let scene: MainScene
    init(scene: MainScene) {
        self.scene = scene
        super.init()
    }
    
    func buttonPressed(sender:UIButton) {
        print("button pressed")
        let vc = UIViewController.viewController(UIColor.yellowColor())
        self.scene.nc.pushViewController(vc, animated: true)
    }
}

let vc = UIViewController.viewController(UIColor.greenColor())
vc.title = "title"

let button = UIButton(type: .System) as UIButton
button.setTitle("press me", forState: UIControlState.Normal)
button.sizeToFit()
button.center = vc.view.center
vc.view.addSubview(button)

let mainScene = MainScene(vc: vc)

let handeler = ButtonHandler(scene: mainScene)

button.addTarget(handeler, action: #selector(ButtonHandler.buttonPressed(_:)), forControlEvents: UIControlEvents.TouchUpInside)


//Run playground
let window = UIWindow(frame: UIScreen.mainScreen().bounds)
window.rootViewController = mainScene.nc
window.makeKeyAndVisible()
CFRunLoopRun()
