//
//  ViewController.swift
//  Creating simple concurrency using Operations
//
//  Created by Domenico Solazzo on 13/05/15.
//  License MIT
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Convenience constructor
        let countingOperation = CountingOperation()
        // Create the NSOperationQueue
        let queue = OperationQueue()
        // Add the operation to the queue
        queue.addOperation(countingOperation)
    }
}

