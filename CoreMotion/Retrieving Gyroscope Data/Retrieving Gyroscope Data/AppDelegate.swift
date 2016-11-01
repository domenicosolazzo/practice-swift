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
    lazy var queue = OperationQueue()
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        if manager.isGyroAvailable{
            
            if manager.isGyroActive == false{
                
                manager.gyroUpdateInterval = 1.0 / 40.0
                
                manager.startGyroUpdates(to: queue,
                    withHandler: {(data: CMGyroData!, error: NSError!) in
                        
                        print("Gyro Rotation x = \(data?.rotationRate.x)")
                        print("Gyro Rotation y = \(data?.rotationRate.y)")
                        print("Gyro Rotation z = \(data?.rotationRate.z)")
                        
                } as! CMGyroHandler)
                
            } else {
                print("Gyro is already active")
            }
            
        } else {
            print("Gyro isn't available")
        }

        return true
    }

}

