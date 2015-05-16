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

}

