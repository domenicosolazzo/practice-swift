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

    
    func application(application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
            
            if let options = launchOptions{
                
                /* Do we have a value? */
                let value =
                options[UIApplicationLaunchOptionsLocalNotificationKey]
                    as? UILocalNotification
                
                if let notification = value{
                    print("Opening the app because of a notification...")
                    self.application(application ,
                        didReceiveLocalNotification: notification)
                }
            } else {
                print("Asking for permission...")
                askForNotificationPermissionForApplication(application)
            }
            
            return true
    }
    
    func application(application: UIApplication,
        didReceiveLocalNotification notification: UILocalNotification) {
            
            let key1Value = notification.userInfo!["Key 1"] as? NSString
            let key2Value = notification.userInfo!["Key 2"] as? NSString
            
            if key1Value != nil && key2Value != nil{
                /* We got our notification */
                print("We got the notification")
            } else {
                /* This is not the notification that we composed */
            }
            
    }
    
    func application(application: UIApplication,
        didRegisterUserNotificationSettings
        notificationSettings: UIUserNotificationSettings){
            
            if notificationSettings.types == []{
                /* The user did not allow us to send notifications */
                return
            }
            
            scheduleLocalNotification()
            
    }

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
        let settings = UIUserNotificationSettings(forTypes: [.Alert, .Badge],
            categories: nil)
        
        application.registerUserNotificationSettings(settings)
        
    }


}

