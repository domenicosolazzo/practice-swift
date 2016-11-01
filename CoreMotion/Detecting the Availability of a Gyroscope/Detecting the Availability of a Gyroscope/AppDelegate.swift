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

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        let motionManager = CMMotionManager()
        
        if motionManager.isGyroAvailable{
            print("Gyroscope is available")
        }else{
            print("Gyroscope is not available")
        }
        
        if motionManager.isGyroActive{
            print("Gyroscope is active")
        }else{
            print("Gyroscope is not active")
        }
        
        return true
    }



}

