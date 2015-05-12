//
//  ViewController.swift
//  Performing Task after a delay
//
//  Created by Domenico Solazzo on 12/05/15.
//  License MIT
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let delayInSeconds = 2.0
        
        // Current time
        let currentTime:dispatch_time_t = DISPATCH_TIME_NOW
        // Delta
        let deltaTime: Int64 = Int64(delayInSeconds * Double(NSEC_PER_SEC))
        // The delay in nanoseconds will be equal:
        // delay = currentTime * deltaTime
        let delayInNanoSeconds = dispatch_time(currentTime, deltaTime)
        
        // Fetch the concurrent queue
        let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        
        // Dispatch this block after a given delay
        dispatch_after(delayInNanoSeconds, queue, {
            println("This message is printed after \(delayInNanoSeconds) ns");
        })
        
    }
}

