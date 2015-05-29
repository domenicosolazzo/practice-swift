//
//  ViewController.swift
//  Setting Up an App with CloudKit
//
//  Created by Domenico on 29/05/15.
//  License MIT
//

import UIKit
import CloudKit

class ViewController: UIViewController {
    let container = CKContainer.defaultContainer()
    
    // Fetch the current logged-in user in iCloud
    func handleIdentityChanged(notification: NSNotification){
        
        let fileManager = NSFileManager()
        
        if let token = fileManager.ubiquityIdentityToken{
            println("The new token is \(token)")
        } else {
            println("User has logged out of iCloud")
        }
        
    }
    
    /* Start listening for iCloud user change notifications */
    func applicationBecameActive(notification: NSNotification){
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "handleIdentityChanged:",
            name: NSUbiquityIdentityDidChangeNotification,
            object: nil)
    }
    
    /* Stop listening for those notifications when the app becomes inactive */
    func applicationBecameInactive(notification: NSNotification){
        NSNotificationCenter.defaultCenter().removeObserver(self,
            name: NSUbiquityIdentityDidChangeNotification,
            object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* Find out when the app is becoming active and inactive
        so that we can find out when the user's iCloud logging status changes.*/
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "applicationBecameActive:",
            name: UIApplicationDidBecomeActiveNotification,
            object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "applicationBecameInactive:",
            name: UIApplicationWillResignActiveNotification,
            object: nil)
        
    }
    
    
    
    /* Just a little method to help us display alert dialogs to the user */
    func displayAlertWithTitle(title: String, message: String){
        let controller = UIAlertController(title: title,
            message: message,
            preferredStyle: .Alert)
        
        controller.addAction(UIAlertAction(title: "OK",
            style: .Default,
            handler: nil))
        
        presentViewController(controller, animated: true, completion: nil)
        
    }
}

