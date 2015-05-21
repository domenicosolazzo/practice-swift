//
//  AppDelegate.swift
//  Retrieving Pedometer Data
//
//  Created by Domenico on 21/05/15.
//  License MIT
//

import UIKit
import CoreMotion

extension NSDate{
    class func now() -> NSDate{
        return NSDate()
    }
    
    class func yesterday() -> NSDate{
        return NSDate(timeIntervalSinceNow: -(24 * 60 * 60))
    }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    lazy var pedometer = CMPedometer()
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        return true
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Check if the step count is available
        if CMPedometer.isStepCountingAvailable() {
            let date = NSDate()// Since when you want to start to measure the number of steps
            pedometer.startPedometerUpdatesFromDate(date, withHandler: { (data:CMPedometerData!, error:NSError!) -> Void in
                println("Number of steps: \(data.numberOfSteps)")
            })
        }else{
            println("Steps are not available")
        }
    }
    
    func applicationWillResignActive(application: UIApplication) {
        pedometer.stopPedometerUpdates()
    }

}

