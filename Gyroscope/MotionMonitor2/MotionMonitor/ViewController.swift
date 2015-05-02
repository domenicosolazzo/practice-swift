//
//  ViewController.swift
//  MotionMonitor
//
//  Created by Domenico on 02/05/15.
//  Copyright (c) 2015 Domenico. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    @IBOutlet var gyroscopeLabel:UILabel!
    @IBOutlet var accelerometerLabel:UILabel!
    @IBOutlet var attitudeLabel:UILabel!
    
    private let motionManager = CMMotionManager()
    private let queue = NSOperationQueue()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if motionManager.deviceMotionAvailable {
            motionManager.deviceMotionUpdateInterval = 0.1
            motionManager.startDeviceMotionUpdatesToQueue(queue,
                withHandler: {
                    (motion:CMDeviceMotion!, error:NSError!) -> Void in
                    
                    let rotationRate = motion.rotationRate
                    let gravity = motion.gravity
                    let userAcc = motion.userAcceleration
                    let attitude = motion.attitude
                    
                    let gyroscopeText =
                    String(format:"Rotation Rate:\n-----------------\n" +
                        "x: %+.2f\ny: %+.2f\nz: %+.2f\n",
                        rotationRate.x, rotationRate.y, rotationRate.z)
                    let acceleratorText =
                    String(format:"Acceleration:\n---------------\n" +
                        "Gravity x: %+.2f\t\tUser x: %+.2f\n" +
                        "Gravity y: %+.2f\t\tUser y: %+.2f\n" +
                        "Gravity z: %+.2f\t\tUser z: %+.2f\n",
                        gravity.x, userAcc.x, gravity.y,
                        userAcc.y, gravity.z,userAcc.z)
                    let attitudeText =
                    String(format:"Attitude:\n----------\n" +
                        "Roll: %+.2f\nPitch: %+.2f\nYaw: %+.2f\n",
                        attitude.roll, attitude.pitch, attitude.yaw)
                    
                    // You need to dispatch the results to the main queue
                    dispatch_async(dispatch_get_main_queue(), {
                        self.gyroscopeLabel.text = gyroscopeText
                        self.accelerometerLabel.text = acceleratorText
                        self.attitudeLabel.text = attitudeText
                    })
            })
        }
    }

}

