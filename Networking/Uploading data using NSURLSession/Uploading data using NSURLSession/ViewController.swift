//
//  ViewController.swift
//  Uploading data using NSURLSession
//
//  Created by Domenico Solazzo on 16/05/15.
//  License MIT
//

import UIKit

class ViewController: UIViewController, NSURLSessionDelegate,
        NSURLSessionDataDelegate {

    // Session object
    var session: NSURLSession!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        configuration.timeoutIntervalForRequest = 15
        
        session = NSURLSession(configuration: configuration, delegate: self, delegateQueue: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dataToUpload = "Hello World".dataUsingEncoding(
            NSUTF8StringEncoding,
            allowLossyConversion: false)
        
        let url = NSURL(string: "http://www.domenicosolazzo.com/swiftcode")
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "POST"
        
        var task = session.uploadTaskWithRequest(request, fromData: dataToUpload)
        task.resume()
    }
    
    func URLSession(session: NSURLSession, task: NSURLSessionTask, didCompleteWithError error: NSError?) {
        println("Finished to upload...")
        
        session.finishTasksAndInvalidate()
        if error == nil{
            println("Data uploaded successfully")
        }else{
            println("Error uloading data: \(error)")
        }
    }
}

