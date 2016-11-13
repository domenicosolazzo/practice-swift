//
//  ViewController.swift
//  Downloading asynchronously with NSURLConnection
//
//  Created by Domenico Solazzo on 16/05/15.
//  License MIT
//

import UIKit

extension URL{
    /* An extension on the NSURL class that allows us to retrieve the current
    documents folder path */
    static func documentsFolder() -> URL?{
        let fileManager = FileManager()
        do{
        return try fileManager.url(for: .documentDirectory,
                                   in: .userDomainMask,
                                   appropriateFor: nil,
            create: false)
        }catch{
            print("Error")
        }
        return nil
    }
}

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "http://www.domenicosolazzo/swiftcode")
        let request = URLRequest(url: url!)
        
        let operationQueue = OperationQueue()
        
        NSURLConnection.sendAsynchronousRequest(request, queue: operationQueue) {[weak self]
            (response:URLResponse?, data:Data?, error:Error?) -> Void in
            /* Now we may have access to the data, but check if an error came back
            first or not */
            if (data?.count)! > 0 && error == nil{
                
                /* Append the filename to the documents directory */
                let filePath =
                URL.documentsFolder()?.appendingPathComponent("apple.html")
                do{
                    let writtenData = try data!.write(to: filePath!, options: Data.WritingOptions.atomic)
                    if writtenData != nil{
                        print("Successfully saved the file to \(filePath)")
                    } else {
                        print("Failed to save the file to \(filePath)")
                    }
                }catch{
                    print("Error")
                }
                
            } else if data?.count == 0 && error == nil{
                print("Nothing was downloaded")
            } else if error != nil{
                print("Error happened = \(error)")
            }
        }
    }
}

