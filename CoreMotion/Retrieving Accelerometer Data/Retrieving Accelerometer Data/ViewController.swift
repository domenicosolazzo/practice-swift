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
        
        if motionManager.isAccelerometerAvailable{
            _ = OperationQueue()
            motionManager.startAccelerometerUpdates(to: OperationQueue.main) { [weak self] (data: CMAccelerometerData?, error: Error?) in
                    
                    print("X = \(data?.acceleration.x)")
                    print("Y = \(data?.acceleration.y)")
                    print("Z = \(data?.acceleration.z)")
                    
                
            }
        } else {
            print("Accelerometer is not available")
        }

    }
}

