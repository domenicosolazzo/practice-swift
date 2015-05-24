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
            displayAlertWithTitle("TouchID error", message: "Sorry! TouchID is not available");
        }
    }
    @IBAction func useTouchID(sender: UIButton) {
        let context = LAContext()
        var error: NSError?
        
        let reason = "Please authenticate with TouchID"
        context.evaluatePolicy(
            LAPolicy.DeviceOwnerAuthenticationWithBiometrics,
            localizedReason: reason) {[weak self](success:Bool, error:NSError!) -> Void in
                var title = "Touch ID Result";
                var message = "You have been authenticated"
                
                if success == false{
                    message = "Failed to authenticate you."
                    if let theError = error{
                        message = "\(message). Error: \(theError)"
                    }
                }
                
                self!.displayAlertWithTitle(title, message: message);
                
                
        }
    }
    
    func displayAlertWithTitle(title: String, message: String){
        let alertController = UIAlertController(
            title: title,
            message: message,
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

