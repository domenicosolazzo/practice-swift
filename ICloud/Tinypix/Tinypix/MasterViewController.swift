//
//  MasterViewController.swift
//  Tinypix
//
//  Created by Domenico on 27.04.15.
//  Copyright (c) 2015 Domenico Solazzo. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {
    @IBOutlet var colorControl: UISegmentedControl!
    private var documentFileNames: [String] = []
    private var chosenDocument: TinyPixDocument?
    
    //- MARK: Helper methods
    private func urlForFileName(fileName: NSString) -> NSURL {
        let fm = NSFileManager.defaultManager()
        let urls = fm.URLsForDirectory(NSSearchPathDirectory.DocumentDirectory,
            inDomains: NSSearchPathDomainMask.UserDomainMask) as! [NSURL]
        let directoryURL = urls[0]
        let fileURL = directoryURL.URLByAppendingPathComponent(fileName as String)
        return fileURL
    }
    
    private func reloadFiles() {
        let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory,
            NSSearchPathDomainMask.UserDomainMask, true) as! [String]
        let path = paths[0]
        let fm = NSFileManager.defaultManager()
        
        var error:NSError? = nil;
        let files = fm.contentsOfDirectoryAtPath(path, error: &error) as? [String]
        if files != nil {
            let sortedFileNames = sorted(files!) { fileName1, fileName2 in
                let file1Path = path.stringByAppendingPathComponent(fileName1)
                let file2Path = path.stringByAppendingPathComponent(fileName2)
                let attr1 = fm.attributesOfItemAtPath(file1Path, error: nil)
                let attr2 = fm.attributesOfItemAtPath(file2Path, error: nil)
                let file1Date = attr1![NSFileCreationDate] as! NSDate
                let file2Date = attr2![NSFileCreationDate] as! NSDate
                let result = file1Date.compare(file2Date)
                return result == NSComparisonResult.OrderedAscending
            }
            
            documentFileNames = sortedFileNames
            tableView.reloadData()
        } else {
            println("Error listing files in directory \(path): \(error)")
        }
    }
    
    //- MARK: UITableView
    
}

