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

}

