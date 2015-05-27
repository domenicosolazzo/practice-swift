//
//  AppDelegate.swift
//  Saving Objects to File
//
//  Created by Domenico on 27/05/15.
//  License MIT
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        let path = NSTemporaryDirectory() + "person"
        var firstPerson = Person()
        NSKeyedArchiver.archiveRootObject(firstPerson, toFile: path)
        
        var secondPerson = NSKeyedUnarchiver.unarchiveObjectWithFile(path)
            as! Person!
        
        if firstPerson == secondPerson{
            println("Both persons are the same")
        } else {
            println("Could not read the archive")
        }
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        // Override point for customization after application launch.
        self.window!.backgroundColor = UIColor.whiteColor()
        self.window!.makeKeyAndVisible()
        return true
    }
}

