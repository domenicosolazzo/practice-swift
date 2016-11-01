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
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        return true
    }
    
    func getDocumentFolder() -> URL?{
        let fileManager = FileManager()
        let urls = fileManager.urls(
            for: FileManager.SearchPathDirectory.documentDirectory,
            in: FileManager.SearchPathDomainMask.userDomainMask)
        if urls.count > 0{
            let url = urls[0] 
            print(url)
            return url
        }
        
        return nil
        
    }
    
    func getCacheFolder() -> URL?{
        let fileManager = FileManager()
        let urls = fileManager.urls(
            for: FileManager.SearchPathDirectory.cachesDirectory,
            in: FileManager.SearchPathDomainMask.userDomainMask)
        if urls.count > 0{
            let url = urls[0] 
            print(url)
            return url
        }
        
        return nil
        
    }
    
    func getTemporaryFolder() -> URL? {
        _ = NSTemporaryDirectory()
        return nil
    }
}

