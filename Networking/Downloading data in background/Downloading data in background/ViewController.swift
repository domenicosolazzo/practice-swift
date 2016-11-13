//
//  ViewController.swift
//  Downloading data in background
//
//  Created by Domenico Solazzo on 16/05/15.
//  License MIT
//

import UIKit

class ViewController: UIViewController, URLSessionDelegate,
        URLSessionDownloadDelegate, URLSessionTaskDelegate {

    // Session object
    var session: Foundation.URLSession!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        let configuration = URLSessionConfiguration.backgroundSessionConfiguration(configurationIdentifier)
        configuration.timeoutIntervalForRequest = 15
        
        session = Foundation.URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let url = URL(string: "http://goo.gl/mf9xj3")
        let task = session.downloadTask(with: url!)
        task.resume()
    }
    
    //- MARK: URLSession delegates
    // This method indicates if we received new data
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        print("Received data")
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        print("Finished...")
        
        if error == nil{
            print("...without error")
        }else{
            print("...with error. Error \(error)")
        }
        
        session.finishTasksAndInvalidate()
    }
    
    func urlSession(_ session: URLSession,
        downloadTask: URLSessionDownloadTask,
        didFinishDownloadingTo location: URL){
            print("Finished writing the downloaded content to URL = \(location)")
    }
    //- MARK: Computer properties
    /* This computed property will generate a unique identifier for our
    background session configuration. The first time it is used, it will get
    the current date and time and return that as a string to you. It will
    also save that string into the system defaults so that it can retrieve
    it the next time it is called. This computed property's value
    is persistent between launches of this app.
    */
    var configurationIdentifier: String{
        let userDefaults = UserDefaults.standard
        let key = "configurationIdentifier"
        let previousValue = userDefaults.string(forKey: key) as String?
        
        if previousValue != nil{
            return previousValue!
        }else{
            let newValue = Date().description
            userDefaults.set(newValue, forKey: key)
            userDefaults.synchronize()
            return newValue
        }
    }
    //- MARK: Helper Methods
    func showAlertWithTitle(_ title:String, message:String){
        let controller = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        controller.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        present(controller, animated: true, completion: nil)
    }
}

