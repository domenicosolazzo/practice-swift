//
//  AppDelegate.swift
//  Retrieving Gyroscope Data
//
//  Created by Domenico on 21/05/15.
//  License MIT
//

import UIKit
import CoreMotion

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    lazy var manager = CMMotionManager()
    lazy var queue = NSOperationQueue()
    
    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        if manager.gyroAvailable{
            
            if manager.gyroActive == false{
                
                manager.gyroUpdateInterval = 1.0 / 40.0
                
                manager.startGyroUpdatesToQueue(queue,
                    withHandler: {(data: CMGyroData!, error: NSError!) in
                        
                        println("Gyro Rotation x = \(data.rotationRate.x)")
                        println("Gyro Rotation y = \(data.rotationRate.y)")
                        println("Gyro Rotation z = \(data.rotationRate.z)")
                        
                })
                
            } else {
                println("Gyro is already active")
            }
            
        } else {
            println("Gyro isn't available")
        }

        return true
    }

}

