//
//  AppDelegate.swift
//  Retrieving Altitude Data
//
//  Created by Domenico Solazzo on 20/05/15.
//  License MIT
//

import UIKit
import CoreMotion

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    /* The altimeter instance that will deliver our altitude updates if they
    are available on the host device */
    lazy var altimeter = CMAltimeter()
    /* A private queue on which altitude updates will be delivered to us */
    lazy var queue = OperationQueue()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Check if altimeter data is available
        if CMAltimeter.isRelativeAltitudeAvailable(){
            // Start updating altimeter data
            altimeter.startRelativeAltitudeUpdates(to: queue, withHandler:
                { (data:CMAltitudeData!, error:NSError!) -> Void in
                print("Got the altitude. Data: \(data.relativeAltitude)")
            } as! CMAltitudeHandler)
        }
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Stop receiving updates
        altimeter.stopRelativeAltitudeUpdates()
    }
}

