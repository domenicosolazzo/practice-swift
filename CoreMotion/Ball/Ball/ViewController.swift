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
    fileprivate let updateInterval = 1.0/60.0
    fileprivate let motionManager = CMMotionManager()
    fileprivate let queue = OperationQueue()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        motionManager.deviceMotionUpdateInterval = updateInterval
        motionManager.startDeviceMotionUpdates(to: queue,
            withHandler: {
                (motionData: CMDeviceMotion!, error: NSError!) -> Void in
                let ballView = self.view as! BallView
                ballView.acceleration = motionData.gravity
                DispatchQueue.main.asynchronously(DispatchQueue.mainexecute: {
                    ballView.update()
                })
        } as! CMDeviceMotionHandler)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

