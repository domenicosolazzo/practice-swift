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
}

