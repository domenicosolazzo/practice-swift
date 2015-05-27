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
    
    func saveAndReadArray(){
        
        let path = NSTemporaryDirectory() + "MyFile.txt"
        let arrayOfNames:NSArray = ["Steve", "John", "Edward"]
        
        if arrayOfNames.writeToFile(path, atomically: true){
            let readArray:NSArray? = NSArray(contentsOfFile: path)
            if let array = readArray{
                println("Could read the array back = \(array)")
            } else {
                println("Failed to read the array back")
            }
        }
        
    }

}

