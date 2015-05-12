//
//  ViewController.swift
//  Performing UI-Related Tasks
//
//  Created by Domenico Solazzo on 12/05/15.
//  License MIT
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dispatch_async(dispatch_get_main_queue(), {[weak self] in
            println("Current thread: \(NSThread.currentThread())")
            println("Main thread: \(NSThread.mainThread())")
            
            let alertController = UIAlertController(
                title: "GCD",
                message: "GCD is amazing",
                preferredStyle: UIAlertControllerStyle.Alert)
            
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            
            self!.presentViewController(alertController, animated: true, completion: nil)
        })
    }
}

