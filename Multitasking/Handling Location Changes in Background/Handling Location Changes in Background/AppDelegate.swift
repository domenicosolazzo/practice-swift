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
}

