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

    @IBAction func checkAvailability(_ sender: UIButton) {
        // Handle for using the TouchID API
        let context = LAContext()
        var error: NSError?
        
        let isTouchIDAvailable = context.canEvaluatePolicy(
            LAPolicy.deviceOwnerAuthenticationWithBiometrics,
            error: &error)
        
        useButton.isEnabled = isTouchIDAvailable
        
        if isTouchIDAvailable == false{
            displayAlertWithTitle("TouchID error", message: "Sorry! TouchID is not available");
        }
    }
    @IBAction func useTouchID(_ sender: UIButton) {
        let context = LAContext()
        var _: NSError
        
        let reason = "Please authenticate with TouchID"
        
        context.evaluatePolicy(
            LAPolicy.deviceOwnerAuthenticationWithBiometrics,
            localizedReason: reason) {[weak self](success:Bool, error:NSError?) -> Void in
                let title = "Touch ID Result";
                var message = "You have been authenticated"
                
                if success == false{
                    message = "Failed to authenticate you."
                    if let theError = error{
                        message = "\(message). Error: \(theError)"
                    }
                }
                
                self!.displayAlertWithTitle(title, message: message);
                
                
        } as! (Bool, Error?) -> Void as! (Bool, Error?) -> Void as! (Bool, Error?) -> Void as! (Bool, Error?) -> Void as! (Bool, Error?) -> Void as! (Bool, Error?) -> Void as! (Bool, Error?) -> Void
    }
    
    func displayAlertWithTitle(_ title: String, message: String){
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(
            UIAlertAction(
                title: "OK",
                style: UIAlertActionStyle.default,
                handler: nil
            )
        )
        self.present(alertController, animated: true, completion: nil)
    }
}

