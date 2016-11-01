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
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let path = NSTemporaryDirectory() + "person"
        let firstPerson = Person()
        NSKeyedArchiver.archiveRootObject(firstPerson, toFile: path)
        
        let secondPerson = NSKeyedUnarchiver.unarchiveObject(withFile: path)
            as! Person!
        
        if firstPerson == secondPerson{
            print("Both persons are the same")
        } else {
            print("Could not read the archive")
        }
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        // Override point for customization after application launch.
        self.window!.backgroundColor = UIColor.white
        self.window!.makeKeyAndVisible()
        return true
    }
}

