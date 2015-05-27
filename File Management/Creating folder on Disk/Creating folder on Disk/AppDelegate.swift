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
        let imagesPath = tempPath.stringByAppendingPathComponent("images")
        var error:NSError?
        let fileManager = NSFileManager()
        
        if fileManager.createDirectoryAtPath(imagesPath,
            withIntermediateDirectories: true,
            attributes: nil,
            error: nil){
                println("Created the directory")
        } else {
            println("Could not create the directory")
        }
    }
    

}

