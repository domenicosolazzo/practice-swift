//
//  ViewController.swift
//  Authenticating the User with Touch ID
//
//  Created by Domenico on 24/05/15.
//  License MIT
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var useButton: UIButton!

    @IBAction func checkAvailability(sender: UIButton) {
        // Handle for using the TouchID API
        let context = LAContext()
        var error: NSError?
        
        let isTouchIDAvailable = context.canEvaluatePolicy(
            LAPolicy.DeviceOwnerAuthenticationWithBiometrics,
            error: &error)
        
        useButton.enabled = isTouchIDAvailable
        
        if isTouchIDAvailable == false{
            let alertController = UIAlertController(
                title: "TouchID error",
                message: "Sorry! TouchID is not available",
                preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(
                UIAlertAction(
                    title: "OK",
                    style: UIAlertActionStyle.Default,
                    handler: nil
                )
            )
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    @IBAction func useTouchID(sender: UIButton) {
    }
}

