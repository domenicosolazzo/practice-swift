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
    lazy var queue = NSOperationQueue()
}

