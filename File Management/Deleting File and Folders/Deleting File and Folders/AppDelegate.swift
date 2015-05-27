//
//  AppDelegate.swift
//  Deleting File and Folders
//
//  Created by Domenico on 27/05/15.
//  License MIT
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func createAndDelete(){
        
        let fileManager = NSFileManager()
        
        func createFolderAtPath(path: String){
            
            var error:NSError?
            
            if fileManager.createDirectoryAtPath(path,
                withIntermediateDirectories: true,
                attributes: nil,
                error: &error) == false && error != nil{
                    println("Failed to create folder at \(path), error = \(error!)")
            }
            
        }
        
        /* Creates 5 .txt files in the given folder, named 1.txt, 2.txt, etc */
        func createFilesInFolder(folder: String){
            
            for counter in 1...5{
                let fileName = NSString(format: "%lu.txt", counter)
                let path = folder.stringByAppendingPathComponent(String(fileName))
                let fileContents = "Some text"
                var error:NSError?
                if fileContents.writeToFile(path,
                    atomically: true,
                    encoding: NSUTF8StringEncoding,
                    error: &error) == false{
                        if let theError = error{
                            println("Failed to save the file at path \(path)" +
                                " with error = \(theError)")
                        }
                }
            }
            
        }
        
        /* Enumerates all files/folders at a given path */
        func enumerateFilesInFolder(folder: String){
            
            var error:NSError?
            let contents = fileManager.contentsOfDirectoryAtPath(
                folder,
                error: &error)!
            
            if let theError = error{
                println("An error occurred \(theError)")
            } else if contents.count == 0{
                println("No content was found")
            } else {
                println("Contents of path \(folder) = \(contents)")
            }
            
        }
        
        /* Deletes all files/folders in a given path */
        func deleteFilesInFolder(folder: String){
            
            var error:NSError?
            let contents = fileManager.contentsOfDirectoryAtPath(folder,
                error: &error) as! [String]
            
            if let theError = error{
                println("An error occurred = \(theError)")
            } else {
                for fileName in contents{
                    let filePath = folder.stringByAppendingPathComponent(fileName)
                    if fileManager.removeItemAtPath(filePath, error: nil){
                        println("Successfully removed item at path \(filePath)")
                    } else {
                        println("Failed to remove item at path \(filePath)")
                    }
                }
            }
            
        }
        
        /* Deletes a folder with a given path */
        func deleteFolderAtPath(path: String){
            
            var error:NSError?
            if fileManager.removeItemAtPath(path, error: &error){
                println("Successfully deleted the path \(path)")
            } else {
                if let theError = error{
                    println("Failed to remove path \(path) with error \(theError)")
                }
            }
            
        }
        
        let txtFolder = NSTemporaryDirectory().stringByAppendingPathComponent("txt")
        
        createFolderAtPath(txtFolder)
        createFilesInFolder(txtFolder)
        enumerateFilesInFolder(txtFolder)
        deleteFilesInFolder(txtFolder)
        enumerateFilesInFolder(txtFolder)
        deleteFolderAtPath(txtFolder)
        
    }
}

