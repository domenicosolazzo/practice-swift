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
    var myTimer: Timer?
    
    // Check if multitasking is supported
    func isMultitaskingSupported() -> Bool{
        return UIDevice.current.isMultitaskingSupported
    }
    
    func timerMethod(_ sender: Timer){
        // The amount of time that the app can run in background
        let backgroundTimeRemaining = UIApplication.shared.backgroundTimeRemaining
        
        if backgroundTimeRemaining == DBL_MAX{
            print("Background Time Remaining = Undetermined")
        } else {
            print("Background Time Remaining = " +
                "\(backgroundTimeRemaining) Seconds")
        }
    }
    
    func endBackgroundTask(){
        // Get the main queue
        let queue = DispatchQueue.main
        
        queue.async(execute: {[weak self] in
            if let timer = self!.myTimer{
                timer.invalidate()
                self!.myTimer = nil
                UIApplication.shared.endBackgroundTask(self!.backgroundTaskIdentifier)
                self!.backgroundTaskIdentifier = UIBackgroundTaskInvalid
            }
            
        })
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        if isMultitaskingSupported() == false{
            return
        }
        
        myTimer = Timer.scheduledTimer(timeInterval: 1.0,
            target: self,
            selector: #selector(AppDelegate.timerMethod(_:)),
            userInfo: nil,
            repeats: true
        )
        
        backgroundTaskIdentifier = application.beginBackgroundTask(
            withName: "task1",
            expirationHandler: {[weak self] in
                self!.endBackgroundTask()
            }
        )
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        if backgroundTaskIdentifier != UIBackgroundTaskInvalid{
            self.endBackgroundTask()
        }
    }
    
}

