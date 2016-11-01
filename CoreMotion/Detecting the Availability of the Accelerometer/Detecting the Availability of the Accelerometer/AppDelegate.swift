//
//  AppDelegate.swift
//  Detecting the Availability of the Accelerometer
//
//  Created by Domenico on 21/05/15.
//  License MIT
//

import UIKit
import CoreMotion

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let motionManager = CMMotionManager()
        
        // Check if the accelerometer is available
        if motionManager.isAccelerometerAvailable{
            print("The accelerometer is available")
        }else{
            print("The accelerometer is not available")
        }
        
        // Check if the acceleromter is active
        if motionManager.isAccelerometerActive{
            print("The accelerometer is active")
        }else{
            print("The accelerometer is not active")
        }
        
        return true
    }
}

