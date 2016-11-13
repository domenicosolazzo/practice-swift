//
//  ViewController.swift
//  Downloading an url using NSURLSession - DownloadTask
//
//  Created by Domenico Solazzo  on 16/05/15.
//  License MIT
//

import UIKit

class ViewController: UIViewController, URLSessionDelegate {
    
    // Session object
    var session: URLSession!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        // Configuration object
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 15
        
        session = URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        var urlString = "http://goo.gl/mf9xj3"
        var url = URL(string: urlString)
        
        var task = session.downloadTask(with: url!, completionHandler: {[weak self]
            (url:URL!, response:URLResponse!, error:NSError!) in
            if error == nil{
                
                // NSFileManager
                let manager = FileManager()
                
                /* Get the path to the caches folder */
                var destinationPath = try manager.url(
                    for: FileManager.SearchPathDirectory.cachesDirectory,
                    in: FileManager.SearchPathDomainMask.userDomainMask,
                    appropriateFor: url,
                    create: true
                )
                
                // Extract the name of the downloaded file
                let componentsOfUrl = url.absoluteString.componentsSeparated(by: "/")
                let fileNameOfUrl = componentsOfUrl[componentsOfUrl.count - 1]
                
                // Append the name of the file to the destination folder
                destinationPath = destinationPath.appendingPathComponent(fileNameOfUrl)
                
                // Move the file over
                try manager.moveItem(at: url, to: destinationPath)
                
                // Message
                let message = "Saved the downloaded data to \(destinationPath)"
                self!.showAlertWithTitle("Saved", message: message)
                
            }else{
                print("Error: \(error)")
                self!.showAlertWithTitle("Error", message: "Could not download the data! Error: \(error)")
            }
        } as! (URL?, URLResponse?, Error?) -> Void)
        
        // Start the task
        task.resume()
    }
    
    //- MARK: Helper methods
    func showAlertWithTitle(_ title: String, message:String){
        let controller = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        controller.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        present(controller, animated: true, completion: nil)
    }
}

