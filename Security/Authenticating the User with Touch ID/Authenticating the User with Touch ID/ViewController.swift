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
    }
    @IBAction func useTouchID(sender: UIButton) {
    }
}

