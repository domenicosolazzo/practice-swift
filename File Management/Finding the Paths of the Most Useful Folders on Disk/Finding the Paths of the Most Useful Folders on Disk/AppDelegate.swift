//
//  AppDelegate.swift
//  Finding the Paths of the Most Useful Folders on Disk
//
//  Created by Domenico on 27/05/15.
//  License MIT
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        return true
    }
    
    func getDocumentFolder() -> NSURL?{
        let fileManager = NSFileManager()
        let urls = fileManager.URLsForDirectory(
            NSSearchPathDirectory.DocumentDirectory,
            inDomains: NSSearchPathDomainMask.UserDomainMask)
        if urls.count > 0{
            let url = urls[0] as! NSURL
            println(url)
            return url
        }
        
        return nil
        
    }
    
    func getTemporaryFolder() -> NSURL? {
        if let tempDirectory = NSTemporaryDirectory(){
            println("\(tempDirectory)")
            return tempDirectory as! NSURL
        } else {
            println("Could not find the temp directory")
        }
        
        return nil
    }
}

