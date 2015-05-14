//
//  AppDelegate.swift
//  Completing a Long-Running task in Background
//
//  Created by Domenico Solazzo on 14/05/15.
//  License MIT
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    // Background task identifier
    var backgroundTaskIdentifier: UIBackgroundTaskIdentifier =
    UIBackgroundTaskInvalid
    
    // Timer
    var myTimer: NSTimer?
    
    // Check if multitasking is supported
    func isMultitaskingSupported() -> Bool{
        return UIDevice.currentDevice().multitaskingSupported
    }
    
    func timerMethod(sender: NSTimer){
        // The amount of time that the app can run in background
        let backgroundTimeRemaining = UIApplication.sharedApplication().backgroundTimeRemaining
        
        if backgroundTimeRemaining == DBL_MAX{
            println("Background Time Remaining = Undetermined")
        } else {
            println("Background Time Remaining = " +
                "\(backgroundTimeRemaining) Seconds")
        }
    }
    
    func endBackgroundTask(){
        // Get the main queue
        let queue = dispatch_get_main_queue()
        
        dispatch_async(queue, {[weak self] in
            if let timer = self!.myTimer{
                timer.invalidate()
                self!.myTimer = nil
                UIApplication.sharedApplication().endBackgroundTask(self!.backgroundTaskIdentifier)
                self!.backgroundTaskIdentifier = UIBackgroundTaskInvalid
            }
            
        })
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        if isMultitaskingSupported() == false{
            return
        }
        
        myTimer = NSTimer.scheduledTimerWithTimeInterval(1.0,
            target: self,
            selector: "timerMethod:",
            userInfo: nil,
            repeats: true
        )
        
        backgroundTaskIdentifier = application.beginBackgroundTaskWithName(
            "task1",
            expirationHandler: {[weak self] in
                self!.endBackgroundTask()
            }
        )
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        if backgroundTaskIdentifier != UIBackgroundTaskInvalid{
            self.endBackgroundTask()
        }
    }
    
}

