//
//  AppDelegate.swift
//  Retrieving Pedometer Data
//
//  Created by Domenico on 21/05/15.
//  License MIT
//

import UIKit
import CoreMotion

extension Date{
    static func now() -> Date{
        return Date()
    }
    
    static func yesterday() -> Date{
       return Date(timeIntervalSinceNow: -(24 * 60 * 60))
    }
    
    static func tenMinutesAgo() -> Date{
        return Date(timeIntervalSinceNow: -(10 * 60))
    }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    lazy var pedometer = CMPedometer()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Check if the step count is available
        if CMPedometer.isStepCountingAvailable() {
            let date = Date()// Since when you want to start to measure the number of steps
            pedometer.startUpdates(from: date, withHandler: { (data:CMPedometerData!, error:NSError!) -> Void in
                print("Number of steps: \(data.numberOfSteps)")
            } as! CMPedometerHandler)
        }else{
            print("Steps are not available")
        }
        
        // Check for distance 
        if CMPedometer.isDistanceAvailable(){
            pedometer.queryPedometerData(from: Date.now(), to: Date.yesterday(), withHandler: { (data:CMPedometerData!, error:NSError!) -> Void in
                print("Distance: \(data.distance) m")
            } as! CMPedometerHandler)
        }else{
            print("No distance data")
        }
        
        // Check for Floor count
        if CMPedometer.isFloorCountingAvailable(){
            pedometer.queryPedometerData(from: Date.tenMinutesAgo(), to: Date.now(), withHandler: { (data:CMPedometerData!, error:NSError!) -> Void in
                print("Floor ascended: \(data.floorsAscended)")
                print("Floor descended: \(data.floorsDescended)")
            } as! CMPedometerHandler)
        }else{
            print("No floors data")
        }
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        pedometer.stopUpdates()
    }

}

