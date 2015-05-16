//
//  ViewController.swift
//  Handling Timeouts
//
//  Created by Domenico Solazzo on 16/05/15.
//  License MIT
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* We have a 15 second timeout for our connection */
        let timeout = 15
        
        /* You can choose your own URL here */
        let urlAsString = "http://www.apple.com"
        let url = NSURL(string: urlAsString)
        
        /* Set the timeout on our request here */
        let urlRequest = NSURLRequest(URL: url!,
            cachePolicy: .ReloadIgnoringLocalAndRemoteCacheData,
            timeoutInterval: 15.0)
        
        let queue = NSOperationQueue()
        
        NSURLConnection.sendAsynchronousRequest(urlRequest, queue: queue) {[weak self]
            (response:NSURLResponse!, data:NSData!, error:NSError!) -> Void in
            /* Now we may have access to the data, but check if an error came back
            first or not */
            if data.length > 0 && error == nil{
                let html = NSString(data: data, encoding: NSUTF8StringEncoding)
                println("html = \(html)")
            } else if data.length == 0 && error == nil{
                println("Nothing was downloaded")
            } else if error != nil{
                println("Error happened = \(error)")
            }
        }
    }
}

