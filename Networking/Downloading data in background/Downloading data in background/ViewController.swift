//
//  ViewController.swift
//  Downloading data in background
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
        
        let configuration = NSURLSessionConfiguration.backgroundSessionConfiguration(configurationIdentifier)
        configuration.timeoutIntervalForRequest = 15
        
        session = NSURLSession(configuration: configuration, delegate: self, delegateQueue: nil)
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
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let key = "configurationIdentifier"
        let previousValue = NSUserDefaults.stringForKey(key) as String?
        
        if previousValue != nil{
            return previousValue!
        }else{
            let newValue = NSDate().description
            userDefaults.setObject(newValue, forKey: key)
            userDefaults.synchronize()
            return newValue
        }
    }
    //- MARK: Helper Methods
    func showAlertWithTitle(title:String, message:String){
        var controller = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        controller.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        presentViewController(controller, animated: true, completion: nil)
    }
}

