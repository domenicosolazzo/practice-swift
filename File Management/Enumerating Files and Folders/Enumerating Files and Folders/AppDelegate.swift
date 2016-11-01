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
    func contentsOfAppBundle() -> [URL]{
        
        let propertiesToGet = [
            URLResourceKey.isDirectoryKey,
            URLResourceKey.isReadableKey,
            URLResourceKey.creationDateKey,
            URLResourceKey.contentAccessDateKey,
            URLResourceKey.contentModificationDateKey
        ]
        
        var error:NSError?
        let fileManager = FileManager()
        let bundleUrl = Bundle.main.bundleURL
        let result = try fileManager.contentsOfDirectoryAtURL(bundleUrl,
            includingPropertiesForKeys: propertiesToGet,
            options: nil) as! [URL]
        
        
        return result
        
    }
    
    func stringValueOfBoolProperty(_ property: String, url: URL) -> String{
        var value:AnyObject?
        var error:NSError?
        if try url.getResourceValue(
            &value,
            forKey: URLResourceKey(rawValue: property)) && value != nil{
                let number = value as! NSNumber
                return number.boolValue ? "YES" : "NO"
        }
        
        return "NO"
    }
    
    func isUrlDirectory(_ url: URL) -> String{
        return stringValueOfBoolProperty(URLResourceKey.isDirectoryKey.rawValue, url: url)
    }
    
    func isUrlReadable(_ url: URL) -> NSString{
        return stringValueOfBoolProperty(URLResourceKey.isReadableKey.rawValue, url: url) as NSString
    }
    
    
    func dateOfType(_ type: String, url: URL) -> Date?{
        var value:AnyObject?
        var error:NSError?
        if try url.getResourceValue(
            &value,
            forKey: URLResourceKey(rawValue: type)) && value != nil{
                return value as? Date
        }
        return nil
    }
    
    func printUrlPropertiesToConsole(_ url: URL){
        print("URL name = \(url.lastPathComponent)")
        print("Is a Directory? \(isUrlDirectory(url))")
        print("Is Readable? \(isUrlReadable(url))")
        
        if let creationDate = dateOfType(URLResourceKey.creationDateKey.rawValue, url: url){
            print("Creation Date = \(creationDate)")
        }
        
        if let accessDate = dateOfType(URLResourceKey.contentAccessDateKey.rawValue, url: url){
            print("Access Date = \(accessDate)")
        }
        
        if let modificationDate =
            dateOfType(URLResourceKey.contentModificationDateKey.rawValue, url: url){
                print("Modification Date = \(modificationDate)")
        }
        
        print("-----------------------------------")
        
    }
    
    func application(_ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
            
            let appBundleContents = contentsOfAppBundle()
            
            for url in appBundleContents{
                printUrlPropertiesToConsole(url)
            }
            
            self.window = UIWindow(frame: UIScreen.main.bounds)
            // Override point for customization after application launch.
            self.window!.backgroundColor = UIColor.white
            self.window!.makeKeyAndVisible()
            return true
    }

}

