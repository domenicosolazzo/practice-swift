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
    let container = CKContainer.default()
    
    // Fetch the current logged-in user in iCloud
    func handleIdentityChanged(_ notification: Notification){
        
        let fileManager = FileManager()
        
        if let token = fileManager.ubiquityIdentityToken{
            print("The new token is \(token)")
        } else {
            print("User has logged out of iCloud")
        }
        
    }
    
    /* Start listening for iCloud user change notifications */
    func applicationBecameActive(_ notification: Notification){
        NotificationCenter.default.addObserver(self,
            selector: #selector(ViewController.handleIdentityChanged(_:)),
            name: NSNotification.Name.NSUbiquityIdentityDidChange,
            object: nil)
    }
    
    /* Stop listening for those notifications when the app becomes inactive */
    func applicationBecameInactive(_ notification: Notification){
        NotificationCenter.default.removeObserver(self,
            name: NSNotification.Name.NSUbiquityIdentityDidChange,
            object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* Find out when the app is becoming active and inactive
        so that we can find out when the user's iCloud logging status changes.*/
        NotificationCenter.default.addObserver(self,
            selector: #selector(ViewController.applicationBecameActive(_:)),
            name: NSNotification.Name.UIApplicationDidBecomeActive,
            object: nil)
        
        NotificationCenter.default.addObserver(self,
            selector: #selector(ViewController.applicationBecameInactive(_:)),
            name: NSNotification.Name.UIApplicationWillResignActive,
            object: nil)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        container.accountStatus{[weak self]
            (status: CKAccountStatus, error: Error?) -> Void in
            
            /* Be careful, we might be on a different thread now so make sure that
            your UI operations go on the main thread */
            DispatchQueue.main.async(execute: {
                
                var title: String!
                var message: String!
                
                if error != nil{
                    title = "Error"
                    message = "An error occurred = \(error)"
                } else {
                    
                    title = "No errors occurred"
                    
                    switch status{
                    case .available:
                        message = "The user is logged in to iCloud"
                    case .couldNotDetermine:
                        message = "Could not determine if the user is logged" +
                        " into iCloud or not"
                    case .noAccount:
                        message = "User is not logged into iCloud"
                    case .restricted:
                        message = "Could not access user's iCloud account information"
                    }
                    
                    self!.displayAlertWithTitle(title, message: message)
                    
                }
                
            })
            
        }
        
    }
    
    deinit{
        NotificationCenter.default.removeObserver(self)
    }
    
    /* Just a little method to help us display alert dialogs to the user */
    func displayAlertWithTitle(_ title: String, message: String){
        let controller = UIAlertController(title: title,
            message: message,
            preferredStyle: .alert)
        
        controller.addAction(UIAlertAction(title: "OK",
            style: .default,
            handler: nil))
        
        present(controller, animated: true, completion: nil)
        
    }
}

