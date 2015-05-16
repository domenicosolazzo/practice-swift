//
//  ViewController.swift
//  Get informed of the download's progress
//
//  Created by Domenico Solazzo on 16/05/15.
//  License MIT
//

import UIKit

class ViewController: UIViewController, NSURLSessionDelegate,
            NSURLSessionDataDelegate {
    
    // Session object
    var session: NSURLSession!
    /* We will download a URL one chunk at a time and append the downloaded
    data to this mutable data */
    var mutableData: NSMutableData = NSMutableData()
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        configuration.timeoutIntervalForRequest = 15
        
        session = NSURLSession(configuration: configuration, delegate: self, delegateQueue: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var url = NSURL(string: "http://goo.gl/mf9xj3")
        // When the completion handler is nil, a method from NSURLSessionDataDelegate
        // will be called to show the progress of the download
        var task = session.dataTaskWithURL(url!, completionHandler: nil)
        
        // Start the task
        task.resume()
    }
    
    //- MARK: Helper methods
    func showAlertWithTitle(title:String, message:String){
        var controller = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        controller.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        presentViewController(controller, animated: true, completion: nil)
    }
    
}

