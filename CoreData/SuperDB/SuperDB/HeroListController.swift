//
//  HeroListController.swift
//  SuperDB
//
//  Created by Domenico on 31/05/15.
//  Copyright (c) 2015 Domenico. All rights reserved.
//

import UIKit
import CoreData

class HeroListController: UIViewController, UITableViewDataSource,
            UITableViewDelegate, UITabBarDelegate, NSFetchedResultsControllerDelegate {

    @IBOutlet weak var heroTableView: UITableView!
    @IBOutlet weak var heroTabBar: UITabBar!
    @IBOutlet weak var addButton: UIBarButtonItem!
    let kSelectedTabDefaultsKey = "SelectedTab"
    private var _fetchedResultsController: NSFetchedResultsController!
    
    enum tabBarKeys: Int{
        case ByName
        case BySecretIdentity
    }
    
    @IBAction func addHero(sender: UIBarButtonItem) {
        let  managedObjectContext = fetchedResultsController.managedObjectContext as NSManagedObjectContext
        let entity:NSEntityDescription = fetchedResultsController.fetchRequest.entity!
        NSEntityDescription.insertNewObjectForEntityForName(entity.name!, inManagedObjectContext: managedObjectContext)
        
        var error: NSError?
        
        if !managedObjectContext.save(&error) {
            let title = NSLocalizedString("Error Saving Entity", comment: "Error Saving Entity")
            let message = NSLocalizedString("Error was : \(error?.description), quitting", comment: "Error was : \(error?.description), quitting")
            
            showAlertWithCompletion(title, message:message, buttonTitle:"Ok", completion:{_ in exit(-1)})
        }
    }
    
    override func viewDidLoad() {
        // Adding the editing button
        self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        // Select the TabBar item
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let selectedTab = userDefaults.integerForKey(kSelectedTabDefaultsKey)
        let item = heroTabBar.items?[selectedTab] as! UITabBarItem
        heroTabBar.selectedItem = item
        
        //Fetch any existing entities
        var error: NSError?
        if !fetchedResultsController.performFetch(&error) {
            let title = NSLocalizedString("Error Saving Entity", comment: "Error Saving Entity")
            let message = NSLocalizedString("Error was : \(error?.description), quitting",
                comment: "Error was : \(error?.description), quitting")
            showAlertWithCompletion(title, message: message,
                buttonTitle: "Ok", completion: { _ in exit(-1)})
        }
    }
    //- MARK: UITabBarDelegate
    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem!) {
        let defaults = NSUserDefaults.standardUserDefaults()
        let items: NSArray = heroTabBar.items!
        let tabIndex = items.indexOfObject(item)
        defaults.setInteger(tabIndex, forKey: kSelectedTabDefaultsKey)
        
        NSFetchedResultsController.deleteCacheWithName("Hero")
        _fetchedResultsController = nil
        
        var error: NSError?
        if !fetchedResultsController.performFetch(&error) {
            let title = NSLocalizedString("Error Saving Entity", comment: "Error Saving Entity")
            let message = NSLocalizedString("Error was : \(error?.description), quitting",
                comment: "Error was : \(error?.description), quitting")
            showAlertWithCompletion(title, message:message, buttonTitle:"Ok",
                completion:{_ in exit(-1)})
        } else {
            self.heroTableView.reloadData()
        }
    }
    
    // MARK:- FetchedResultsController Property
    
    private var fetchedResultsController: NSFetchedResultsController {
        get {
            if self._fetchedResultsController != nil{
                return self._fetchedResultsController
            }
            
            let fetchRequest = NSFetchRequest()
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let context = appDelegate.managedObjectContext
            let entity = NSEntityDescription.entityForName("Hero", inManagedObjectContext: context!)
            fetchRequest.entity = entity
            fetchRequest.fetchBatchSize = 20
            
            let array:NSArray = self.heroTabBar.items!
            var tabIndex = array.indexOfObject(self.heroTabBar.selectedItem!)
            if tabIndex == NSNotFound {
                let defaults = NSUserDefaults.standardUserDefaults()
                tabIndex = defaults.integerForKey(kSelectedTabDefaultsKey)
            }
            
            // Sort descriptor
            var sectionKey: String!
            switch (tabIndex){
            case tabBarKeys.ByName.rawValue:
                let sortDescriptor1 = NSSortDescriptor(key: "name", ascending: true)
                let sortDescriptor2 = NSSortDescriptor(key: "secretIdentity", ascending: true)
                var sortDescriptors = NSArray(objects: sortDescriptor1, sortDescriptor2)
                fetchRequest.sortDescriptors = sortDescriptors as [AnyObject]
                sectionKey = "name"
            case tabBarKeys.BySecretIdentity.rawValue:
                let sortDescriptor2 = NSSortDescriptor(key: "name", ascending: true)
                let sortDescriptor1 = NSSortDescriptor(key: "secretIdentity", ascending: true)
                var sortDescriptors = NSArray(objects: sortDescriptor1, sortDescriptor2)
                fetchRequest.sortDescriptors = sortDescriptors as [AnyObject]
                sectionKey = "secretIdentity"
            default:
                ()
            }
            
            let aFetchResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context!, sectionNameKeyPath: sectionKey, cacheName: "Hero")
            aFetchResultsController.delegate = self
            self._fetchedResultsController = aFetchResultsController
            return self._fetchedResultsController
            
            
        }
    }
    
    // MARK: - NSFetchedResultsController Delegate Methods
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        self.heroTableView.beginUpdates()
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.heroTableView.endUpdates()
    }
    
    func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
        switch(type) {
        case .Insert:
            self.heroTableView.insertSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Fade)
        case .Delete:
            self.heroTableView.deleteSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Fade)
        default:
            ()
        }
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch(type) {
        case .Insert:
            self.heroTableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
        case .Delete:
            self.heroTableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
        default:
            ()
        }
    }
    //- MARK: Navigation
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        addButton.enabled = !editing
        heroTableView.setEditing(editing, animated: animated)
    }
    
    func showAlertWithCompletion(title:String, message:String, buttonTitle:String = "OK", completion:((UIAlertAction!)->Void)!){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let okAction = UIAlertAction(title: buttonTitle, style: .Default, handler: completion)
        alert.addAction(okAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return fetchedResultsController.sections?.count ?? 0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        let sectionInfo = fetchedResultsController.sections![section] as! NSFetchedResultsSectionInfo
        return sectionInfo.numberOfObjects
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "HeroListCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! UITableViewCell
        
        // Configure the cell...
        
        let aHero = fetchedResultsController.objectAtIndexPath(indexPath) as! NSManagedObject
        let tabArray = self.heroTabBar.items as NSArray!
        let tab = tabArray.indexOfObject(self.heroTabBar.selectedItem!)
        
        switch (tab){
        case tabBarKeys.ByName.rawValue:
            cell.textLabel?.text = aHero.valueForKey("name") as! String!
            cell.detailTextLabel?.text = aHero.valueForKey("secretIdentity") as! String!
        case tabBarKeys.BySecretIdentity.rawValue:
            cell.detailTextLabel?.text = aHero.valueForKey("name") as! String!
            cell.textLabel?.text = aHero.valueForKey("secretIdentity") as! String!
        default:
            ()
        }
        
        return cell
    }
    
    // Override to support editing the table view.
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        let managedObjectContext = fetchedResultsController.managedObjectContext as NSManagedObjectContext!
        if editingStyle == .Delete {
            // Delete the row from the data source
            //tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            managedObjectContext.deleteObject(fetchedResultsController.objectAtIndexPath(indexPath) as! NSManagedObject)
            var error:NSError?
            if managedObjectContext?.save(&error) == nil {
                let title = NSLocalizedString("Error Saving Entity", comment: "Error Saving Entity")
                let message = NSLocalizedString("Error was : \(error?.description), quitting", comment: "Error was : \(error?.description), quitting")
                showAlertWithCompletion(title, message: message, buttonTitle: "Ok",
                    completion: {_ in exit(-1)})
            }
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
    
}
