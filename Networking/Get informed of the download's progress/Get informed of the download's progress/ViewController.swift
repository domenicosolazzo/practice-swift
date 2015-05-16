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
    //- MARK: URLSessionDataDelegate
    /* This method will get called on a random thread because
    we have not provided an operation queue to our session */
    func URLSession(session: NSURLSession, dataTask: NSURLSessionDataTask, didReceiveData data: NSData) {
        println("New chunck of data...")
        data.enumerateByteRangesUsingBlock {[weak self]
            (pointer:UnsafePointer<Void>,
            range:NSRange,
            stop:UnsafeMutablePointer<ObjCBool>) in
                let newData = NSData(bytes: pointer, length: range.length)
                self!.mutableData.appendData(newData)
        }
    }
    
    // The data have been downloaded
    func URLSession(session: NSURLSession, task: NSURLSessionTask, didCompleteWithError error: NSError?) {
        println("Finished downloading...")
        session.finishTasksAndInvalidate()
        
        dispatch_async(dispatch_get_main_queue(), {[weak self] in
            var message = "Finished downloading the content"
            
            if error != nil{
                message = "Error downloading the content"
            }
            
            self!.showAlertWithTitle("Download content", message: message)
        })
    }
    
    //- MARK: Helper methods
    func showAlertWithTitle(title:String, message:String){
        var controller = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        controller.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        presentViewController(controller, animated: true, completion: nil)
    }
    
}

