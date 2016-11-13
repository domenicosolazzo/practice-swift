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
        let url = URL(string: urlAsString)
        
        let urlRequest = URLRequest(url: url!)
        
        var response: URLResponse?
        var error: NSError?
        
        print("Firing synchronous url connection...")
        
        let dispatchQueue =
        DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.default)
        
        dispatchQueue.async(execute: {
            /* Get the data for our URL, synchronously */
            let data = try NSURLConnection.sendSynchronousRequest(urlRequest,
                                                              returning: &response)
            
            if data != nil && error == nil{
                print("\(data.count) bytes of data was returned")
            }
            else if data.count == 0 && error == nil{
                print("No data was returned")
            }
            else if error != nil{
                print("Error happened = \(error)");
            }

        })
        print("We are done")
    }
}

