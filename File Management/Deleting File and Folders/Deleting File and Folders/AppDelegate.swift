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
                                                 withIntermediateDirectories:true,
                                                 attributes: nil) == false && error != nil{
                print("Failed to create folder at \(path), error = \(error!)")
            }
            
        }
        
        /* Creates 5 .txt files in the given folder, named 1.txt, 2.txt, etc */
        func createFilesInFolder(folder: String){
            
            for counter in 1...5{
                let fileName = NSString(format: "%lu.txt", counter)
                let path = (folder as NSString).stringByAppendingPathComponent(String(fileName))
                let fileContents = "Some text"
                var error:NSError?
                if fileContents.writeToFile(path, atomically: true, encoding: NSStringEncoding){
                    if let theError = error{
                        print("Failed to save the file at path \(path)" +
                            " with error = \(theError)")
                    }
                }
            }
            
        }
        
        /* Enumerates all files/folders at a given path */
        func enumerateFilesInFolder(folder: String){
            
            let error:NSError?
            let contents = try! fileManager.contentsOfDirectoryAtPath(
                folder)
            
            if let theError = error{
                print("An error occurred \(theError)")
            } else if contents.count == 0{
                print("No content was found")
            } else {
                print("Contents of path \(folder) = \(contents)")
            }
            
        }
        
        /* Deletes all files/folders in a given path */
        func deleteFilesInFolder(folder: String){
            
            let error:NSError?
            let contents = (try! fileManager.contentsOfDirectoryAtPath(folder)) 
            
            if let theError = error{
                print("An error occurred = \(theError)")
            } else {
                for fileName in contents{
                    let filePath = (folder as NSString).stringByAppendingPathComponent(fileName)
                    do {
                        try fileManager.removeItemAtPath(filePath)
                        print("Successfully removed item at path \(filePath)")
                    } catch _ {
                        print("Failed to remove item at path \(filePath)")
                    }
                }
            }
            
        }
        
        /* Deletes a folder with a given path */
        func deleteFolderAtPath(path: String){
            
            var error:NSError?
            do {
                try fileManager.removeItemAtPath(path)
                print("Successfully deleted the path \(path)")
            } catch let error1 as NSError {
                error = error1
                if let theError = error{
                    print("Failed to remove path \(path) with error \(theError)")
                }
            }
            
        }
        
        let txtFolder = (NSTemporaryDirectory() as NSString).stringByAppendingPathComponent("txt")
        
        createFolderAtPath(txtFolder)
        createFilesInFolder(txtFolder)
        enumerateFilesInFolder(txtFolder)
        deleteFilesInFolder(txtFolder)
        enumerateFilesInFolder(txtFolder)
        deleteFolderAtPath(txtFolder)
        
    }
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        self.createAndDelete()
        return true
    }
}

