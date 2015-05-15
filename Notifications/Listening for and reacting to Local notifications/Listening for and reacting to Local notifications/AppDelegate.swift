//
//  AppDelegate.swift
//  Listening for and reacting to Local notifications
//
//  Created by Domenico Solazzo on 15/05/15.
//  License MIT
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    //- MARK: Helper methods
    // Scheduling a new notification
    func scheduleLocalNotification(){
        
        let notification = UILocalNotification()
        
        /* Time and timezone settings */
        notification.fireDate = NSDate(timeIntervalSinceNow: 8.0)
        notification.timeZone = NSCalendar.currentCalendar().timeZone
        
        notification.alertBody = "A new item is downloaded."
        
        /* Action settings */
        notification.hasAction = true
        notification.alertAction = "View"
        
        /* Badge settings */
        notification.applicationIconBadgeNumber =
            UIApplication.sharedApplication().applicationIconBadgeNumber + 1
        
        /* Additional information, user info */
        notification.userInfo = [
            "Key 1" : "Value 1",
            "Key 2" : "Value 2"
        ]
        
        /* Schedule the notification */
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
        
    }
    
    func askForNotificationPermissionForApplication(application: UIApplication){
        /* First ask the user if we are
        allowed to perform local notifications */
        let settings = UIUserNotificationSettings(forTypes: .Alert | .Badge,
            categories: nil)
        
        application.registerUserNotificationSettings(settings)
        
    }


}

