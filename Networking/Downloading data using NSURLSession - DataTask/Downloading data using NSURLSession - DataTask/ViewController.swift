//
//  ViewController.swift
//  Downloading data using NSURLSession - DataTask
//
//  Created by Domenico Solazzo on 16/05/15.
//  License MIT
//

import UIKit

class ViewController: UIViewController {
    
    // Session object
    var session: NSURLSession!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        /* Let's create the session configuration first */
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        configuration.timeoutIntervalForRequest = 15
        
        // Create the session object
        session = NSURLSession(configuration: configuration, delegate: nil, delegateQueue: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var urlString = "http://www.domenicosolazzo.com/swiftcode"
        var url = NSURL(string: urlString)
        
        var task = session.dataTaskWithURL(url!, completionHandler: {[weak self]
            (data:NSData!, response:NSURLResponse!, error:NSError!) in
            println("Data: \(data)")
            println("Response: \(response)")
            println("Error: \(error)")
            
            println("Done!")
            // End the session
            self!.session.finishTasksAndInvalidate()
        })
        
        // Start the task
        task.resume();
    
    }

}

