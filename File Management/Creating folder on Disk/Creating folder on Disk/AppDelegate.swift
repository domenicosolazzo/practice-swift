//
//  AppDelegate.swift
//  Creating folder on Disk
//
//  Created by Domenico on 27/05/15.
//  License MIT
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func createFolder(){
        
        let tempPath = NSTemporaryDirectory()
        let imagesPath = (tempPath as NSString).stringByAppendingPathComponent("images")
        var error:NSError?
        let fileManager = NSFileManager()
        
        do {
            try fileManager.createDirectoryAtPath(imagesPath,
                        withIntermediateDirectories: true,
                        attributes: nil)
                print("Created the directory")
        } catch _ {
            print("Could not create the directory")
        }
    }
    

}

