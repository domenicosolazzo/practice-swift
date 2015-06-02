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
        self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.saveButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Save, target: self, action: "save")
        self.backButton = self.navigationItem.leftBarButtonItem
        self.cancelButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: self, action: "cancel")
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "SuperDBEditCell"
        
        // Configure the cell...
        var sectionIndex = indexPath.section
        var rowIndex = indexPath.row
        var _sections = self.sections as NSArray
        var section = _sections.objectAtIndex(sectionIndex) as! NSDictionary
        var rows = section.objectForKey("rows") as! NSArray
        var row = rows.objectAtIndex(rowIndex) as! NSDictionary
        
        // Cell type
        var cellClassName = row.valueForKey("class") as! String
        var cell = tableView.dequeueReusableCellWithIdentifier(cellClassName) as? SuperDBEditCell
        
        if cell == nil {
            switch cellClassName{
            case "SuperDBDateCell":
                cell = SuperDBDateCell(style: .Value2, reuseIdentifier: cellIdentifier)
            case "SuperDBPickerCell":
                cell = SuperDBPickerCell(style: .Value2, reuseIdentifier: cellIdentifier)
            default:
                cell = SuperDBEditCell(style: .Value2, reuseIdentifier: cellIdentifier)
            }
            
        }
        
        if let _values = row["values"] as? NSArray {
            (cell as! SuperDBPickerCell).values = _values as NSArray as [AnyObject]
        }
        
        var dataKey = row.objectForKey("key") as! String!
        cell?.hero = hero
        cell?.key = dataKey
        var theData: String! = self.hero.valueForKey(dataKey)?.description
        cell?.value = theData
        cell?.label.text = row.objectForKey("label") as! String!
        
        return cell!
    }
    
    override func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.None
    }
    //- MARK: Bar Button
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        self.navigationItem.rightBarButtonItem = editing ? self.saveButton : self.editButtonItem()
        self.navigationItem.leftBarButtonItem = editing ? self.cancelButton : self.backButton
    }
    
    //MARK: - (Private) Instance Methods
    
    func save() {
        self.setEditing(false, animated: true)
        for cell in self.tableView.visibleCells() {
            let _cell = cell as! SuperDBEditCell
            if _cell.isEditable() {
                self.hero.setValue(_cell.value, forKey: _cell.key)
            }
            var error: NSError?
            self.hero!.managedObjectContext?.save(&error)
            if error != nil{
                println("Error saving : \(error?.localizedDescription)")
            }
        }
        
        self.tableView.reloadData()
    }
    
    func cancel() {
        self.setEditing(false, animated:true)
    }
}
