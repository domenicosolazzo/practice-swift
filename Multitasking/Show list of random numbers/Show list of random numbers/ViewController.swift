//
//  ViewController.swift
//  Show list of random numbers
//
//  Created by Domenico Solazzo on 12/05/15.
//  License MIT
//

import UIKit

class ViewController: UIViewController {
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // Fetch a concurrent queue
        let concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        
        /* If we have not already saved an array of 10,000
        random numbers to the disk before, generate these numbers now
        and then save them to the disk in an array */
        dispatch_async(concurrentQueue, {[weak self] in
            
            let numberOfValuesRequired = 10000
            
            /* Read the numbers from disk and sort them in an
            ascending fashion */
            dispatch_sync(concurrentQueue, {
                
            })
            
            /* Show the numbers in the main queue */
            dispatch_async(dispatch_get_main_queue(), {
                
            })
        })
        
        
    }
    
    //- MARK: Helpers
    // Find the location of the file
    func findLocation() -> String?{
        /* Get the document folder(s) */
        let folders = NSSearchPathForDirectoriesInDomains(
            NSSearchPathDirectory.DocumentDirectory,
            NSSearchPathDomainMask.UserDomainMask,
            true)
        
        // Did we find anything?
        if folders.count == 0{
            return nil
        }
        
        // Get the first folder
        let folder = folders[0]
        
        /* Append the filename to the end of the documents path */
        return folder.stringByAppendingPathComponent("list.txt")
    }
    
    func hasFileAlreadyBeenCreated() -> Bool{
        let fileManager = NSFileManager()
        if let theLocation = findLocation(){
            return fileManager.fileExistsAtPath(theLocation)
        }
        return false
    }
}

