//
//  HeroDetailController.swift
//  SuperDB
//
//  Created by Domenico on 01/06/15.
//  License MIT
//

import UIKit
import CoreData

class HeroDetailController: UITableViewController {
    var sections: [AnyObject]!
    var hero: NSManagedObject!
    var saveButton: UIBarButtonItem!
    var backButton: UIBarButtonItem!
    var cancelButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        var plistURL = NSBundle.mainBundle().URLForResource("HeroDetailConfiguration", withExtension: "plist")
        var plist = NSDictionary(contentsOfURL: plistURL!)
        self.sections = plist?.valueForKey("sections") as! NSArray as [AnyObject]
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Save, target: self, action: "save")
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "HeroDetailCell"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? UITableViewCell
        
        if cell == nil {
            cell = UITableViewCell(style: .Value2, reuseIdentifier: cellIdentifier)
        }
        
        // Configure the cell...
        var sectionIndex = indexPath.section
        var rowIndex = indexPath.row
        var _sections = self.sections as NSArray
        var section = _sections.objectAtIndex(sectionIndex) as! NSDictionary
        var rows = section.objectForKey("rows") as! NSArray
        var row = rows.objectAtIndex(rowIndex) as! NSDictionary
        
        cell?.textLabel?.text = row.objectForKey("label") as? String
        var dataKey = row.objectForKey("key") as! String!
        
        cell?.detailTextLabel?.text = self.hero.valueForKey(dataKey)!.description as String
        
        return cell!
    }
    
    //- MARK: Bar Button
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        self.navigationItem.rightBarButtonItem = editing ? self.saveButton : self.editButtonItem()
    }
    
    //MARK: - (Private) Instance Methods
    
    func save() {
        self.setEditing(false, animated: true)
    }
}
