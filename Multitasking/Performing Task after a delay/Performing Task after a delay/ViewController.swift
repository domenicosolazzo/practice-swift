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
        let currentTime:DispatchTime = DispatchTime.now()
        // Delta
        let deltaTime: Int64 = Int64(delayInSeconds * Double(NSEC_PER_SEC))
        // The delay in nanoseconds will be equal:
        // delay = currentTime * deltaTime
        let delayInNanoSeconds = currentTime + Double(deltaTime) / Double(NSEC_PER_SEC)
        
        // Fetch the concurrent queue
        let queue = DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.default)
        
        // Dispatch this block after a given delay
        queue.asyncAfter(deadline: delayInNanoSeconds, execute: {
            print("This message is printed after \(delayInNanoSeconds) ns");
        })
        
    }
}

