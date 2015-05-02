//
//  ViewController.swift
//  Ball
//
//  Created by Domenico on 02/05/15.
//  Copyright (c) 2015 Domenico. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    private let updateInterval = 1.0/60.0
    private let motionManager = CMMotionManager()
    private let queue = NSOperationQueue()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        motionManager.deviceMotionUpdateInterval = updateInterval
        motionManager.startDeviceMotionUpdatesToQueue(queue,
            withHandler: {
                (motionData: CMDeviceMotion!, error: NSError!) -> Void in
                let ballView = self.view as! BallView
                ballView.acceleration = motionData.gravity
                dispatch_async(dispatch_get_main_queue(), {
                    ballView.update()
                })
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

