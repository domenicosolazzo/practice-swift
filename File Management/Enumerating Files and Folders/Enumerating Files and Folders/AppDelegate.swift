//
//  AppDelegate.swift
//  Enumerating Files and Folders
//
//  Created by Domenico on 27/05/15.
//  License MIT.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func contentsOfAppBundle() -> [NSURL]{
        
        let propertiesToGet = [
            NSURLIsDirectoryKey,
            NSURLIsReadableKey,
            NSURLCreationDateKey,
            NSURLContentAccessDateKey,
            NSURLContentModificationDateKey
        ]
        
        var error:NSError?
        let fileManager = NSFileManager()
        let bundleUrl = NSBundle.mainBundle().bundleURL
        let result = fileManager.contentsOfDirectoryAtURL(bundleUrl,
            includingPropertiesForKeys: propertiesToGet,
            options: nil,
            error: &error) as! [NSURL]
        
        if let theError = error{
            println("An error occurred")
        }
        
        return result
        
    }
    
    func stringValueOfBoolProperty(property: String, url: NSURL) -> String{
        var value:AnyObject?
        var error:NSError?
        if url.getResourceValue(
            &value,
            forKey: property,
            error: &error) && value != nil{
                let number = value as! NSNumber
                return number.boolValue ? "YES" : "NO"
        }
        
        return "NO"
    }
    
    func isUrlDirectory(url: NSURL) -> String{
        return stringValueOfBoolProperty(NSURLIsDirectoryKey, url: url)
    }
    
    func isUrlReadable(url: NSURL) -> NSString{
        return stringValueOfBoolProperty(NSURLIsReadableKey, url: url)
    }
    
    
    func dateOfType(type: String, url: NSURL) -> NSDate?{
        var value:AnyObject?
        var error:NSError?
        if url.getResourceValue(
            &value,
            forKey: type,
            error: &error) && value != nil{
                return value as? NSDate
        }
        return nil
    }
    
    func printUrlPropertiesToConsole(url: NSURL){
        println("URL name = \(url.lastPathComponent)")
        println("Is a Directory? \(isUrlDirectory(url))")
        println("Is Readable? \(isUrlReadable(url))")
        
        if let creationDate = dateOfType(NSURLCreationDateKey, url: url){
            println("Creation Date = \(creationDate)")
        }
        
        if let accessDate = dateOfType(NSURLContentAccessDateKey, url: url){
            println("Access Date = \(accessDate)")
        }
        
        if let modificationDate =
            dateOfType(NSURLContentModificationDateKey, url: url){
                println("Modification Date = \(modificationDate)")
        }
        
        println("-----------------------------------")
        
    }
    
    func application(application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
            
            let appBundleContents = contentsOfAppBundle()
            
            for url in appBundleContents{
                printUrlPropertiesToConsole(url)
            }
            
            self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
            // Override point for customization after application launch.
            self.window!.backgroundColor = UIColor.whiteColor()
            self.window!.makeKeyAndVisible()
            return true
    }

}

