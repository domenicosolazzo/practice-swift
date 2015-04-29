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
    // Ongoing query
    private var query: NSMetadataQuery!
    // Found documents
    private var documentURLs: [NSURL] = []
    
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
        let fileManager = NSFileManager.defaultManager()
        
        // Passing nil is OK here, matches the first entitlement
        let cloudURL = fileManager.URLForUbiquityContainerIdentifier(nil)
        println("Got cloudURL \(cloudURL)")
        if (cloudURL != nil) {
            query = NSMetadataQuery()
            query.predicate = NSPredicate(format: "%K like '*.tinypix'",
                NSMetadataItemFSNameKey)
            query.searchScopes = [NSMetadataQueryUbiquitousDocumentsScope]
            
            NSNotificationCenter.defaultCenter().addObserver(self,
                selector: "updateUbiquitousDocuments:",
                name: NSMetadataQueryDidFinishGatheringNotification,
                object: nil)
            NSNotificationCenter.defaultCenter().addObserver(self,
                selector: "updateUbiquitousDocuments:",
                name: NSMetadataQueryDidUpdateNotification,
                object: nil)
            
            query.startQuery()
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
    
    private func createFileNamed(fileName: String) {
        // Strips leading and trailing spaces
        let trimmedFileName = fileName.stringByTrimmingCharactersInSet(
            NSCharacterSet.whitespaceCharacterSet())
        if !trimmedFileName.isEmpty {
            let targetName = trimmedFileName + ".tinypix"
            let saveUrl = urlForFileName(targetName)
            chosenDocument = TinyPixDocument(fileURL: saveUrl)
            chosenDocument?.saveToURL(saveUrl,
                forSaveOperation: UIDocumentSaveOperation.ForCreating,
                completionHandler: { success in
                    if success {
                        println("Save OK")
                        self.reloadFiles()
                        self.performSegueWithIdentifier("masterToDetail", sender: self)
                    } else {
                        println("Failed to save!")
                    }
            })
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destination =
        segue.destinationViewController as! UINavigationController
        let detailVC =
        destination.topViewController as! DetailViewController
        
        if sender === self {
            // if sender === self, a new document has just been created,
            // and chosenDocument is already set.
            detailVC.detailItem = chosenDocument
        } else {
            // Find the chosen document from the tableview
            let indexPath = tableView.indexPathForSelectedRow()!
            let filename = documentFileNames[indexPath.row]
            let docURL = urlForFileName(filename)
            chosenDocument = TinyPixDocument(fileURL: docURL)
            chosenDocument?.openWithCompletionHandler() { success in
                if success {
                    println("Load OK")
                    detailVC.detailItem = self.chosenDocument
                } else {
                    println("Failed to load!")
                }
            }
        }
    }
}

