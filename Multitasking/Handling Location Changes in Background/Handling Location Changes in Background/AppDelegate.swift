//
//  AppDelegate.swift
//  Handling Location Changes in Background
//
//  Created by Domenico Solazzo on 14/05/15.
//  License MIT
//

import UIKit
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {

    var window: UIWindow?
    var locationManager: CLLocationManager! = nil
    var isExecutingInBackground = false

    func application(application: UIApplication,
        didFinishLaunchingWithOptions
        launchOptions: [NSObject : AnyObject]?) -> Bool {
            locationManager = CLLocationManager()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.delegate = self
            locationManager.startUpdatingLocation()
            return true
    }
    
    func locationManager(manager: CLLocationManager!,
        didUpdateToLocation newLocation: CLLocation!,
        fromLocation oldLocation: CLLocation!){
            if isExecutingInBackground{
                /* We are in the background. Do not do any heavy processing */
                println("The app is in background")
            } else {
                /* We are in the foreground. Do any processing that you wish */
                println("The app is in foreground")
            }
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        isExecutingInBackground = true
        
        /* Reduce the accuracy to ease the strain on
        iOS while we are in the background */
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        isExecutingInBackground = false
        
        /* Now that our app is in the foreground again, let's increase the location
        detection accuracy */
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
}

