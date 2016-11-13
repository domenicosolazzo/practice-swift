//
//  Person.swift
//  Listening Notifications
//
//  Created by Domenico Solazzo on 15/05/15.
//  License MIT
//

import UIKit

class Person: NSObject {

    // Properties
    var firstName: String?
    var lastName: String?
    
    //- MARK: Initializer
    override init(){
        super.init()
        
        NotificationCenter.default.addObserver(
            // Object observing for this notification
            self,
            // Method that should handle this notification
            selector: #selector(Person.handleSetPersonInfoNotification(_:)),
            // Notification name
            name: NSNotification.Name(rawValue: AppDelegate.notificationName()),
            // Object where the notification is coming from
            object: UIApplication.shared.delegate
        )
        
    }
    
    //- MARK: Notification selectors
    // Listening for the notification for setting the object's properties
    func handleSetPersonInfoNotification(_ notification:Notification){
        self.firstName = (notification as NSNotification).userInfo![AppDelegate.personInfoKeyFirstName()] as? String
        self.lastName = (notification as NSNotification).userInfo![AppDelegate.personInfoKeyLastName()] as? String
    }
    
}
