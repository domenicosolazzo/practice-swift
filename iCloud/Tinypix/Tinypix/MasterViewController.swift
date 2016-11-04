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
    fileprivate var documentFileNames: [String] = []
    fileprivate var chosenDocument: TinyPixDocument?
    // Ongoing query
    fileprivate var query: NSMetadataQuery!
    // Found documents
    fileprivate var documentURLs: [URL] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let addButton = UIBarButtonItem(
            barButtonSystemItem: UIBarButtonSystemItem.add,
            target: self, action: #selector(MasterViewController.insertNewObject))
        navigationItem.rightBarButtonItem = addButton
        
        let prefs = UserDefaults.standard
        let selectedColorIndex = prefs.integer(forKey: "selectedColorIndex")
        setTintColorForIndex(selectedColorIndex)
        colorControl.selectedSegmentIndex = selectedColorIndex
        
        reloadFiles()
        
        // Notification when the user defaults change
        NotificationCenter.default.addObserver(self,
            selector: #selector(MasterViewController.onSettingsChanged(_:)),
            name: UserDefaults.didChangeNotification ,
            object: nil)
    }
    
    func onSettingsChanged(_ notification: Notification) {
        let prefs = UserDefaults.standard
        let selectedColorIndex = prefs.integer(forKey: "selectedColorIndex")
        setTintColorForIndex(selectedColorIndex)
        colorControl.selectedSegmentIndex = selectedColorIndex
    }
    
    //- MARK: Helper methods
    fileprivate func urlForFileName(_ fileName: NSString) -> URL {
        // Be sure to insert "Documents" into the path
        let fm = FileManager.default
        let baseURL = fm.url(forUbiquityContainerIdentifier: nil)
        let pathURL = baseURL?.appendingPathComponent("Documents")
        let destinationURL = pathURL?.appendingPathComponent(fileName as String)
        return destinationURL!
    }
    
    fileprivate func reloadFiles() {
        let fileManager = FileManager.default
        
        // Passing nil is OK here, matches the first entitlement
        // It gives a base URL that will let us access the iCloud directory associated with a particular container identifier
        let cloudURL = fileManager.url(forUbiquityContainerIdentifier: nil)
        println("Got cloudURL \(cloudURL)")
        if (cloudURL != nil) {
            query = NSMetadataQuery()
            query.predicate = NSPredicate(format: "%K like '*.tinypix'",
                NSMetadataItemFSNameKey)
            query.searchScopes = [NSMetadataQueryUbiquitousDocumentsScope]
            
            NotificationCenter.default.addObserver(self,
                selector: #selector(MasterViewController.updateUbiquitousDocuments(_:)),
                name: NSNotification.Name.NSMetadataQueryDidFinishGathering,
                object: nil)
            NotificationCenter.default.addObserver(self,
                selector: #selector(MasterViewController.updateUbiquitousDocuments(_:)),
                name: NSNotification.Name.NSMetadataQueryDidUpdate,
                object: nil)
            
            query.start()
        }
    }
    
    func updateUbiquitousDocuments(_ notification: Notification) {
        documentURLs = []
        documentFileNames = []
        
        println("updateUbiquitousDocuments, results = \(query.results)")
        let results = sorted(query.results) { obj1, obj2 in
            let item1 = obj1 as! NSMetadataItem
            let item2 = obj2 as! NSMetadataItem
            let item1Date =
            item1.value(forAttribute: NSMetadataItemFSCreationDateKey) as! Date
            let item2Date =
            item2.value(forAttribute: NSMetadataItemFSCreationDateKey) as! Date
            let result = item1Date.compare(item2Date)
            return result == ComparisonResult.orderedAscending
        }
        for item in results as! [NSMetadataItem] {
            let url = item.value(forAttribute: NSMetadataItemURLKey) as! URL
            documentURLs.append(url)
            documentFileNames.append(url.lastPathComponent!)
        }
        tableView.reloadData()
    }
    
    //- MARK: UITableView
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return documentFileNames.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt
        indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FileCell") as! UITableViewCell
            let path = documentFileNames[(indexPath as NSIndexPath).row]
            cell.textLabel!.text = path.lastPathComponent.stringByDeletingPathExtension
            return cell
    }
    
    //- MARK: Tint color
    @IBAction func chooseColor(_ sender: UISegmentedControl) {
        let selectedColorIndex = sender.selectedSegmentIndex
        setTintColorForIndex(selectedColorIndex)
        
        let prefs = UserDefaults.standard
        prefs.set(selectedColorIndex, forKey: "selectedColorIndex")
        prefs.synchronize()
        
        // Save the tint color in iCloud
        NSUbiquitousKeyValueStore.default()
            .set(Int64(selectedColorIndex),
                forKey: "selectedColorIndex")
        NSUbiquitousKeyValueStore.default().synchronize()
    }
    
    fileprivate func setTintColorForIndex(_ colorIndex: Int) {
        colorControl.tintColor = TinyPixUtils.getTintColorForIndex(colorIndex)
    }
    
    //- MARK: UIBarButtonItem
    func insertNewObject() {
        let alert = UIAlertController(title: "Choose File Name",
            message: "Enter a name for your new TinyPix document",
            preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let createAction = UIAlertAction(title: "Create", style: .default) { action in
            let textField = alert.textFields![0] 
            self.createFileNamed(textField.text!)
        };
        
        alert.addAction(cancelAction)
        alert.addAction(createAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    fileprivate func createFileNamed(_ fileName: String) {
        // Strips leading and trailing spaces
        let trimmedFileName = fileName.trimmingCharacters(
            in: CharacterSet.whitespaces)
        if !trimmedFileName.isEmpty {
            let targetName = trimmedFileName + ".tinypix"
            let saveUrl = urlForFileName(targetName as NSString)
            chosenDocument = TinyPixDocument(fileURL: saveUrl)
            chosenDocument?.save(to: saveUrl,
                for: UIDocumentSaveOperation.forCreating,
                completionHandler: { success in
                    if success {
                        println("Save OK")
                        self.reloadFiles()
                        self.performSegue(withIdentifier: "masterToDetail", sender: self)
                    } else {
                        println("Failed to save!")
                    }
            })
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination =
        segue.destination as! UINavigationController
        let detailVC =
        destination.topViewController as! DetailViewController
        
        if sender === self {
            // if sender === self, a new document has just been created,
            // and chosenDocument is already set.
            detailVC.detailItem = chosenDocument
        } else {
            // Find the chosen document from the tableview
            let indexPath = tableView.indexPathForSelectedRow!
            let filename = documentFileNames[indexPath.row]
            let docURL = urlForFileName(filename as NSString)
            chosenDocument = TinyPixDocument(fileURL: docURL)
            chosenDocument?.open() { success in
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

