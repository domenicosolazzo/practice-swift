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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let addButton = UIBarButtonItem(
            barButtonSystemItem: UIBarButtonSystemItem.Add,
            target: self, action: "insertNewObject")
        navigationItem.rightBarButtonItem = addButton
        
        let prefs = NSUserDefaults.standardUserDefaults()
        let selectedColorIndex = prefs.integerForKey("selectedColorIndex")
        setTintColorForIndex(selectedColorIndex)
        colorControl.selectedSegmentIndex = selectedColorIndex
        
        reloadFiles()
    }
    
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
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return documentFileNames.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath
        indexPath: NSIndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCellWithIdentifier("FileCell") as! UITableViewCell
            let path = documentFileNames[indexPath.row]
            cell.textLabel!.text = path.lastPathComponent.stringByDeletingPathExtension
            return cell
    }
    
    //- MARK: Tint color
    @IBAction func chooseColor(sender: UISegmentedControl) {
        let selectedColorIndex = sender.selectedSegmentIndex
        setTintColorForIndex(selectedColorIndex)
        
        let prefs = NSUserDefaults.standardUserDefaults()
        prefs.setInteger(selectedColorIndex, forKey: "selectedColorIndex")
        prefs.synchronize()
    }
    
    private func setTintColorForIndex(colorIndex: Int) {
        colorControl.tintColor = TinyPixUtils.getTintColorForIndex(colorIndex)
    }
    
    //- MARK: UIBarButtonItem
    func insertNewObject() {
        let alert = UIAlertController(title: "Choose File Name",
            message: "Enter a name for your new TinyPix document",
            preferredStyle: .Alert)
        alert.addTextFieldWithConfigurationHandler(nil)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        let createAction = UIAlertAction(title: "Create", style: .Default) { action in
            let textField = alert.textFields![0] as! UITextField
            self.createFileNamed(textField.text)
        };
        
        alert.addAction(cancelAction)
        alert.addAction(createAction)
        
        presentViewController(alert, animated: true, completion: nil)
    }
}

