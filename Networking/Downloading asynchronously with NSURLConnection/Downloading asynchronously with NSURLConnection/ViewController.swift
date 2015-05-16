//
//  ViewController.swift
//  Downloading asynchronously with NSURLConnection
//
//  Created by Domenico Solazzo on 16/05/15.
//  License MIT
//

import UIKit

extension NSURL{
    /* An extension on the NSURL class that allows us to retrieve the current
    documents folder path */
    class func documentsFolder() -> NSURL{
        let fileManager = NSFileManager()
        return fileManager.URLForDirectory(.DocumentDirectory,
            inDomain: .UserDomainMask,
            appropriateForURL: nil,
            create: false,
            error: nil)!
    }
}

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = NSURL(string: "http://www.domenicosolazzo/swiftcode")
        let request = NSURLRequest(URL: url!)
        
        let operationQueue = NSOperationQueue()
        
        NSURLConnection.sendAsynchronousRequest(request, queue: operationQueue) {[weak self]
            (response:NSURLResponse!, data:NSData!, error:NSError!) in
            /* Now we may have access to the data, but check if an error came back
            first or not */
            if data.length > 0 && error == nil{
                
                /* Append the filename to the documents directory */
                let filePath =
                NSURL.documentsFolder().URLByAppendingPathComponent("apple.html")
                
                if data.writeToURL(filePath, atomically: true){
                    println("Successfully saved the file to \(filePath)")
                } else {
                    println("Failed to save the file to \(filePath)")
                }
                
            } else if data.length == 0 && error == nil{
                println("Nothing was downloaded")
            } else if error != nil{
                println("Error happened = \(error)")
            }
        }
    }
}

