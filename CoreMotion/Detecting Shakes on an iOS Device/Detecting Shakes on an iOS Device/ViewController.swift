//
//  ViewController.swift
//  Detecting Shakes on an iOS Device
//
//  Created by Domenico on 21/05/15.
//  License MIT
//

import UIKit
import CoreMotion

class ViewController: UIViewController {

    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent) {
        if motion == .MotionShake{
            let controller = UIAlertController(title: "Shake",
                message: "The device is shaken",
                preferredStyle: .Alert)
            
            controller.addAction(UIAlertAction(title: "OK",
                style: .Default,
                handler: nil))
            
            presentViewController(controller, animated: true, completion: nil)
            
        }
    }
}

