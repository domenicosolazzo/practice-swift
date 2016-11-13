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

    func application(_ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
            
            let dispatchQueue =
            DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.default)
            
            dispatchQueue.async(execute: {
                /* Replace this URL with the URL of a file that is
                rather big in size */
                let urlAsString = "http://www.apple.com"
                let url = URL(string: urlAsString)
                let urlRequest = URLRequest(url: url!)
                
                do{
                    let data = try NSURLConnection.sendSynchronousRequest(urlRequest,
                                                                          returning: nil)
                
                
                if data.count == 0{
                    /* No data came back */
                }
                }catch{
                    print("Error")
                }
                
            })
            
            return true
    }
}

