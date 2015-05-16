//
//  ViewController.swift
//  Downloading synchronously with NSURLConnection
//
//  Created by Domenico Solazzo on 16/05/15.
//  License MIT
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* You can have a custom URL here */
        let urlAsString = "http://www.domenicosolazzo.com"
        let url = NSURL(string: urlAsString)
        
        let urlRequest = NSURLRequest(URL: url!)
        
        var response: NSURLResponse?
        var error: NSError?
        
        println("Firing synchronous url connection...")
        
        let dispatchQueue =
        dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        
        dispatch_async(dispatchQueue, {
            /* Get the data for our URL, synchronously */
            let data = NSURLConnection.sendSynchronousRequest(urlRequest,
                returningResponse: &response,
                error: &error)
            
            if data != nil && error == nil{
                println("\(data!.length) bytes of data was returned")
            }
            else if data!.length == 0 && error == nil{
                println("No data was returned")
            }
            else if error != nil{
                println("Error happened = \(error)");
            }

        })
        println("We are done")
    }
}

