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
    let kSelectedTabDefaultsKey = "SelectedTab"
    private var _fetchedResultsController: NSFetchedResultsController!
    
    enum tabBarKeys: Int{
        case ByName
        case BySecretIdentity
    }
    
    override func viewDidLoad() {
        // Adding the editing button
        self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        // Select the TabBar item
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let selectedTab = userDefaults.integerForKey(kSelectedTabDefaultsKey)
        let item = heroTabBar.items?[selectedTab] as! UITabBarItem
        heroTabBar.selectedItem = item
    }
    //- MARK: UITabBarDelegate
    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem!) {
        let defaults = NSUserDefaults.standardUserDefaults()
        let items: NSArray = heroTabBar.items!
        let tabIndex = items.indexOfObject(item)
        defaults.setInteger(tabIndex, forKey: kSelectedTabDefaultsKey)
    }
    
    //- MARK: UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("HeroListCell", forIndexPath: indexPath) as! UITableViewCell
        return cell
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
}
