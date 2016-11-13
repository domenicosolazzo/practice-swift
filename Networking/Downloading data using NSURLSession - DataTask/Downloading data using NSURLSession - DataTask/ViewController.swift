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
    var session: URLSession!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        /* Let's create the session configuration first */
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 15
        
        // Create the session object
        session = URLSession(configuration: configuration, delegate: nil, delegateQueue: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString = "http://www.domenicosolazzo.com/swiftcode"
        let url = URL(string: urlString)
        
        let task = session.dataTask(with: url!, completionHandler: {[weak self]
            (data:Data?, response:URLResponse?, error:NSError?) in
            print("Data: \(data)")
            print("Response: \(response)")
            print("Error: \(error)")
            
            print("Done!")
            // End the session
            self!.session.finishTasksAndInvalidate()
        } as! (Data?, URLResponse?, Error?) -> Void)
        
        // Start the task
        task.resume();
    
    }

}

