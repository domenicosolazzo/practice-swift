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
        let url = URL(string: urlAsString)
        
        /* Set the timeout on our request here */
        let urlRequest = URLRequest(url: url!,
            cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
            timeoutInterval: 15.0)
        
        let queue = OperationQueue()
        
        NSURLConnection.sendAsynchronousRequest(urlRequest, queue: queue) {[weak self]
            (response:URLResponse?, data:Data?, error:Error?) -> Void in
            /* Now we may have access to the data, but check if an error came back
            first or not */
            if (data?.count)! > 0 && error == nil{
                let html = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                print("html = \(html)")
            } else if data?.count == 0 && error == nil{
                print("Nothing was downloaded")
            } else if error != nil{
                print("Error happened = \(error)")
            }
        }
        
    }
}

