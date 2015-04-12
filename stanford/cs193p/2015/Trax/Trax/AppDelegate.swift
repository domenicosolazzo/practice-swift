//
//  AppDelegate.swift
//  Trax
//
//  Created by Domenico on 12.04.15.
//  Copyright (c) 2015 Domenico Solazzo. All rights reserved.
//

import UIKit

struct GPXURL{
    static let Notification = "GPX Notification"
    static let Key = "GPX key"
}
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, handleOpenURL url: NSURL) -> Bool {
        // Get the notification center
        var center = NSNotificationCenter.defaultCenter()
        // Push the notification
        var notification = NSNotification(name: GPXURL.Notification, object: self, userInfo: [GPXURL.Key: url])
        center.postNotification(notification)
        return true
    }


}

