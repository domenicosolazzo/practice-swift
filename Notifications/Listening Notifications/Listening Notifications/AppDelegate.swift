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
}

