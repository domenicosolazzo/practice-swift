//
//  AppDelegate.swift
//  Writing to and Reading from Files
//
//  Created by Domenico on 27/05/15.
//  License MIT
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func saveAndReadString(){
        let someText = NSString(string: "Put some string here")
        let destinationPath = NSTemporaryDirectory() + "MyFile.txt"
        var error:NSError?
        
        let written = someText.writeToFile(destinationPath,
            atomically: true,
            encoding: NSUTF8StringEncoding,
            error: &error)
        
        if written{
            println("Successfully stored the file at path \(destinationPath)")
        } else {
            if let errorValue = error{
                println("An error occurred: \(errorValue)")
            }
        }
    }

}

