//
//  ViewController.swift
//  Downloading an url using NSURLSession - DownloadTask
//
//  Created by Domenico Solazzo  on 16/05/15.
//  License MIT
//

import UIKit

class ViewController: UIViewController, NSURLSessionDelegate {
    
    // Session object
    var session: NSURLSession!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Configuration object
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        configuration.timeoutIntervalForRequest = 15
        
        session = NSURLSession(configuration: configuration, delegate: self, delegateQueue: nil)
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        var urlString = "http://goo.gl/mf9xj3"
        var url = NSURL(string: urlString)
        
        var task = session.downloadTaskWithURL(url!, completionHandler: {[weak self]
            (url:NSURL!, response:NSURLResponse!, error:NSError!) in
            if error == nil{
                
                // NSFileManager
                let manager = NSFileManager()
                
                /* Get the path to the caches folder */
                var error: NSError?
                var destinationPath = manager.URLForDirectory(
                    NSSearchPathDirectory.CachesDirectory,
                    inDomain: NSSearchPathDomainMask.UserDomainMask,
                    appropriateForURL: url,
                    create: true,
                    error: &error
                )!
                
                // Extract the name of the downloaded file
                let componentsOfUrl = url.absoluteString!.componentsSeparatedByString("/")
                let fileNameOfUrl = componentsOfUrl[componentsOfUrl.count - 1]
                
                // Append the name of the file to the destination folder
                destinationPath = destinationPath.URLByAppendingPathComponent(fileNameOfUrl)
                
                // Move the file over
                manager.moveItemAtURL(url, toURL: destinationPath, error: nil)
                
                // Message
                let message = "Saved the downloaded data to \(destinationPath)"
                self!.showAlertWithTitle("Saved", message: message)
                
            }else{
                println("Error: \(error)")
                self!.showAlertWithTitle("Error", message: "Could not download the data! Error: \(error)")
            }
        })
        
        // Start the task
        task.resume()
    }
    
    //- MARK: Helper methods
    func showAlertWithTitle(title: String, message:String){
        let controller = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        controller.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        presentViewController(controller, animated: true, completion: nil)
    }
}

