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
        // Printing the current thread and main queue
        println("Current queue: \(NSThread.currentThread())")
        println("Main queue: \(NSThread.mainThread())")
        
        // Get the concurrent queue
        println("Fetching the queue: DISPATCH_QUEUE_PRIORITY_DEFAULT")
        let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        // Sending a block object to the queue
        dispatch_async(queue, {
            
            dispatch_sync(queue, {
                println("Downloading the image...")
                println("Current queue: \(NSThread.currentThread())")
                // Download the picture here
            })
            
            dispatch_sync(dispatch_get_main_queue(), {
                // Show the image in the UI
                println("Current queue: \(NSThread.currentThread())")
            })
        
        })
    }
}

