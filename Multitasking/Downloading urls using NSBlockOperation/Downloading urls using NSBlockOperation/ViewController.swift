//
//  ViewController.swift
//  Downloading urls using NSBlockOperation
//
//  Created by Domenico Solazzo on 13/05/15.
//  License MIT
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* Define our operation here using a block operation */
        let operation = BlockOperation(block: downloadUrls)
        
        /* Create an operation queue */
        let operationQueue = OperationQueue()
        
        /* We assume that the reason we are downloading the content
        to disk is that the user wanted us to and that it was "user initiated" */
        operationQueue.qualityOfService = QualityOfService.userInitiated
        
        /* We will avoid overloading the system with too many URL downloads
        and download only a few simultaneously */
        operationQueue.maxConcurrentOperationCount = 3
        // Add the operation
        operationQueue.addOperation(operation)
        
    }
    
    //- MARK: Helpers
    func downloadUrls(urls: Array<NSURL>){
        // Download the images
        for url in urls{
            let request = NSURLRequest(url: url as URL)
            NSURLConnection.sendAsynchronousRequest(
                request as URLRequest,
                queue: OperationQueue.current!,
                completionHandler: {
                    (response:URLResponse?, data:Data?, error:Error?) -> Void in
                    if let theError = error{
                        print("Error: \(theError)")
                    }else{
                        print("Downloading the picture and saving it in the disk")
                    }
            })
        }
    }
    
    func downloadUrls(){
        let urls = [
            "http://goo.gl/oMnO9k",
            "http://goo.gl/3rABU1",
            "http://goo.gl/DS3kRe"
        ]
        
        // Convert all the string in NSURL
        var arrayUrls = Array<NSURL>()
        for str in urls{
            arrayUrls.append(NSURL(string: str)!)
        }
        
        // Download all the urls
        downloadUrls(urls: arrayUrls)
    }
}

