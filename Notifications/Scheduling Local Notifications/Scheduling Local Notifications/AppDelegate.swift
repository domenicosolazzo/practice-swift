//
//  AppDelegate.swift
//  Scheduling Local Notifications
//
//  Created by Domenico Solazzo on 15/05/15.
//  License MIT
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        /* First ask the user if we are
        allowed to perform local notifications */
        let settings = UIUserNotificationSettings(forTypes: .Alert,
            categories: nil)
        
        application.registerUserNotificationSettings(settings)
        
        return true
    }
    
    func application(application: UIApplication, didRegisterUserNotificationSettings notificationSettings: UIUserNotificationSettings) {
        if notificationSettings.types == nil{
            /* The user did not allow us to send notifications */
            return
        }
        
        let notification = UILocalNotification()
        
        
        // This is a property of type NSDate that dictates to iOS
        // when the instance of the local notification has to be fired. This is required.
        notification.fireDate = NSDate(timeIntervalSinceNow: 8)
        
        // The time zone in which the given fire-date is specified
        notification.timeZone = NSCalendar.currentCalendar().timeZone
        
        // The text that has to be displayed to the user when 
        // your notification is displayed on screen
        notification.alertBody = "A new item has been downloaded"
        
        notification.hasAction = true
        // It represents the action that the user can take on your local notification
        notification.alertAction = "View"
        
        // The badge number for your app icon
        notification.applicationIconBadgeNumber++
        
        // More additional information about the local notification
        notification.userInfo = [
            "Key 1": "Value1",
            "Key 2": "Value2"
        ]
        
        /* Schedule the notification */
        application.scheduleLocalNotification(notification)
    }
}

