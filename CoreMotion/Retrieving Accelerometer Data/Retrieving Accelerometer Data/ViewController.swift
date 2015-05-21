//
//  ViewController.swift
//  Retrieving Accelerometer Data
//
//  Created by Domenico on 21/05/15.
//  License MIT
//

import UIKit
import CoreMotion

class ViewController: UIViewController {

    lazy var motionManager = CMMotionManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if motionManager.accelerometerAvailable{
            let queue = NSOperationQueue()
            motionManager.startAccelerometerUpdatesToQueue(queue, withHandler:
                {(data: CMAccelerometerData!, error: NSError!) in
                    
                    println("X = \(data.acceleration.x)")
                    println("Y = \(data.acceleration.y)")
                    println("Z = \(data.acceleration.z)")
                    
                }
            )
        } else {
            println("Accelerometer is not available")
        }

    }
}

