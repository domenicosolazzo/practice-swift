//
//  ViewController.swift
//  Download an Image on a concurrent queue
//
//  Created by Domenico Solazzo on 12/05/15.
//  License MIT
//

import UIKit

class ViewController: UIViewController {
    override func viewDidAppear(animated: Bool) {
        
        // Get the concurrent queue
        println("Fetching the queue: DISPATCH_QUEUE_PRIORITY_DEFAULT")
        let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        // Sending a block object to the queue
        dispatch_async(queue, {
            
            dispatch_sync(queue, {
                // Download the picture here
            })
            
            dispatch_sync(dispatch_get_main_queue(), {
                // Show the image in the UI
            })
        
        })
    }
}

