//
//  AppDelegate.swift
//  Detecting the Availability of a Gyroscope
//
//  Created by Domenico on 21/05/15.
//  License MIT
//

import UIKit
import CoreMotion

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        let motionManager = CMMotionManager()
        
        if motionManager.gyroAvailable{
            println("Gyroscope is available")
        }else{
            println("Gyroscope is not available")
        }
        
        if motionManager.gyroActive{
            println("Gyroscope is active")
        }else{
            println("Gyroscope is not active")
        }
        
        return true
    }



}

