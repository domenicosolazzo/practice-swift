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
    
}

