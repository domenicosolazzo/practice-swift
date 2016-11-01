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
        
        let fileManager = FileManager()
        
        func createFolderAtPath(_ path: String){
            
            
            do{
                try fileManager.createDirectory(atPath: path,
                                                 withIntermediateDirectories:true,
                                                 attributes: nil)
                            
            }catch{
                print("Failed to create folder at \(path), error = \(error)")

            }
            
        }
        
        /* Creates 5 .txt files in the given folder, named 1.txt, 2.txt, etc */
        func createFilesInFolder(_ folder: String){
            
            for counter in 1...5{
                let fileName = NSString(format: "%lu.txt", counter)
                let path = (folder as NSString).appendingPathComponent(String(fileName))
                let fileContents = "Some text"
                do{
                    try fileContents.write(toFile: path, atomically: true, encoding: String.Encoding.utf8)
                }catch{
                    print("Failed to save the file at path \(path)")
                }
            }
            
        }
        
        /* Enumerates all files/folders at a given path */
        func enumerateFilesInFolder(_ folder: String){
            
            do{
                _ = try fileManager.contentsOfDirectory(
                atPath: folder)
            }catch{
                print("error")
            }
        }
        
        /* Deletes all files/folders in a given path */
        func deleteFilesInFolder(_ folder: String){
            
            do{
                let contents = (try fileManager.contentsOfDirectory(atPath: folder))
                for fileName in contents{
                    let filePath = (folder as NSString).appendingPathComponent(fileName)
                    do {
                        try fileManager.removeItem(atPath: filePath)
                        print("Successfully removed item at path \(filePath)")
                    } catch _ {
                        print("Failed to remove item at path \(filePath)")
                    }
                }
            }catch{
                print("error")
            }
        }
        
        /* Deletes a folder with a given path */
        func deleteFolderAtPath(_ path: String){
            
            var error:NSError?
            do {
                try fileManager.removeItem(atPath: path)
                print("Successfully deleted the path \(path)")
            } catch let error1 as NSError {
                error = error1
                if let theError = error{
                    print("Failed to remove path \(path) with error \(theError)")
                }
            }
            
        }
        
        let txtFolder = (NSTemporaryDirectory() as NSString).appendingPathComponent("txt")
        
        createFolderAtPath(txtFolder)
        createFilesInFolder(txtFolder)
        enumerateFilesInFolder(txtFolder)
        deleteFilesInFolder(txtFolder)
        enumerateFilesInFolder(txtFolder)
        deleteFolderAtPath(txtFolder)
        
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.createAndDelete()
        return true
    }
}

