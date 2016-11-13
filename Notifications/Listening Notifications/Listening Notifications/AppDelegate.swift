//
//  AppDelegate.swift
//  Listening Notifications
//
//  Created by Domenico Solazzo on 15/05/15.
//  License MIT
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    /* The name of the notification that we are going to send */
    class func notificationName() -> String{
        return "SetPersonInfoNotification"
    }
    /* The first-name key in the user-info dictionary of our notification */
    class func personInfoKeyFirstName () -> String{
        return "firstName"
    }
    /* The last-name key in the user-info dictionary of our notification */
    class func personInfoKeyLastName() -> String{
        return "lastName"
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let person = Person()
        
        // Dictionary to be sent with the notification
        let additionalInfo = [
            self.classForCoder.personInfoKeyFirstName(): "Domenico",
            self.classForCoder.personInfoKeyLastName(): "Solazzo"
        ]
        
        // Notification
        
        let notification = Notification(name:Notification.Name("Notification"))
        
        /* The person class is currently listening for this
        notification. That class will extract the first name and last name
        from it and set its own first name and last name based on the
        userInfo dictionary of the notification. */
        NotificationCenter.default.post(notification)
        
        
        if let firstName = person.firstName{
            print("Person's first name is: \(firstName)")
        }
        if let lastName = person.lastName{
            print("Person's last name is: \(lastName)")
        }
        return true
    }
}

