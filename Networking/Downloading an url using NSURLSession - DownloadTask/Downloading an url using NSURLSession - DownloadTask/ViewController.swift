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

    //- MARK: Helper methods
    func showAlertWithTitle(title: String){
        let controller = UIAlertController(title: title, message: nil, preferredStyle: UIAlertControllerStyle.Alert)
        
        controller.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        presentViewController(controller, animated: true, completion: nil)
    }
}

