//
//  ViewController.swift
//  Show list of random numbers
//
//  Created by Domenico Solazzo on 12/05/15.
//  License MIT
//

import UIKit

class ViewController: UIViewController {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Fetch a concurrent queue
        let concurrentQueue = DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.default)
        
        /* If we have not already saved an array of 10,000
        random numbers to the disk before, generate these numbers now
        and then save them to the disk in an array */
        concurrentQueue.async(execute: {[weak self] in
            
            let numberOfValuesRequired = 10000
            
            // Check if the file has been already created
            if self!.hasFileAlreadyBeenCreated() == false{
                // Creating the file 
                concurrentQueue.sync(execute: {
                    var arrayOfRandomNumbers = [Int]()
                    
                    for _ in 0..<numberOfValuesRequired{
                        // Random number
                        let num = Int(arc4random())
                        arrayOfRandomNumbers.append(num)
                    }
                    
                    // Write the file to disk
                    let array = arrayOfRandomNumbers as NSArray
                    array.write(toFile: self!.findLocation()!, atomically: true)
                })
            }
            
            /* Read the numbers from disk and sort them in an
            ascending fashion */
            concurrentQueue.sync(execute: {
                /* If the file has been created, we have to read it */
                if self!.hasFileAlreadyBeenCreated() {
                    let randomNumbers = NSMutableArray(contentsOfFile: self!.findLocation()!)
                    
                    // Sort the array
                    randomNumbers!.sort(comparator: {
                        (obj1: AnyObject!, obj2: AnyObject!) -> ComparisonResult in
                        let number1 = obj1 as! NSNumber
                        let number2 = obj2 as! NSNumber
                        return number1.compare(number2)
                    } as! (Any, Any) -> ComparisonResult)
                }
            })
            
            /* Show the numbers in the main queue */
            DispatchQueue.main.async(execute: {
                if let numbers = randomNumbers{
                    if numbers.count > 0{
                        /* Refresh the UI here using the numbers in the
                        randomNumbers array */
                        print("The sorted array was read back from disk = \(numbers)")
                    } else {
                        print("The numbers array is emtpy")
                    }
                }
            })
        })
        
        
    }
    
    //- MARK: Helpers
    // Find the location of the file
    func findLocation() -> String?{
        /* Get the document folder(s) */
        let folders = NSSearchPathForDirectoriesInDomains(
            FileManager.SearchPathDirectory.documentDirectory,
            FileManager.SearchPathDomainMask.userDomainMask,
            true)
        
        // Did we find anything?
        if folders.count == 0{
            return nil
        }
        
        // Get the first folder
        let folder = folders[0] as NSString
        
        /* Append the filename to the end of the documents path */
        return folder.appendingPathComponent("list.txt")
    }
    
    func hasFileAlreadyBeenCreated() -> Bool{
        let fileManager = FileManager()
        if let theLocation = findLocation(){
            return fileManager.fileExists(atPath: theLocation)
        }
        return false
    }
}

