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

}

