//
//  AppDelegate.swift
//  Handling Network Connections in Background
//
//  Created by Domenico Solazzo on 14/05/15.
//  License MIT
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
            
            let dispatchQueue =
            dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
            
            dispatch_async(dispatchQueue, {
                /* Replace this URL with the URL of a file that is
                rather big in size */
                let urlAsString = "http://www.apple.com"
                let url = NSURL(string: urlAsString)
                let urlRequest = NSURLRequest(URL: url!)
                let queue = NSOperationQueue()
                var error: NSError?
                
                let data = NSURLConnection.sendSynchronousRequest(urlRequest,
                    returningResponse: nil,
                    error: &error)
                
                if data != nil && error == nil{
                    /* Date did come back */
                }
                else if data!.length == 0 && error == nil{
                    /* No data came back */
                }
                else if error != nil{
                    /* Error happened. Make sure you handle this properly */
                }
            })
            
            return true
    }
}

