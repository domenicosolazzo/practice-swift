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
            
            // Check if the file has been already created
            if self!.hasFileAlreadyBeenCreated() == false{
                // Creating the file 
                dispatch_sync(concurrentQueue, {
                    var arrayOfRandomNumbers = [Int]()
                    
                    for _ in 0..<numberOfValuesRequired{
                        // Random number
                        let num = Int(arc4random())
                        arrayOfRandomNumbers.append(num)
                    }
                    
                    // Write the file to disk
                    let array = arrayOfRandomNumbers as NSArray
                    array.writeToFile(self!.findLocation()!, atomically: true)
                })
            }
            
            /* Read the numbers from disk and sort them in an
            ascending fashion */
            dispatch_sync(concurrentQueue, {
                /* If the file has been created, we have to read it */
                if self!.hasFileAlreadyBeenCreated() {
                    let randomNumbers = NSMutableArray(contentsOfFile: self!.findLocation()!)
                    
                    // Sort the array
                    randomNumbers!.sortUsingComparator({
                        (obj1: AnyObject!, obj2: AnyObject!) -> NSComparisonResult in
                        let number1 = obj1 as NSNumber
                        let number2 = obj2 as NSNumber
                        return number1.compare(number2)
                    })
                }
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

