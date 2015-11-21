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
        let plistURL = NSBundle.mainBundle().URLForResource("HeroDetailConfiguration", withExtension: "plist")
        let plist = NSDictionary(contentsOfURL: plistURL!)
        self.sections = plist?.valueForKey("sections") as! NSArray as [AnyObject]
        self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.saveButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Save, target: self, action: "save")
        self.backButton = self.navigationItem.leftBarButtonItem
        self.cancelButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: self, action: "cancel")
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "SuperDBEditCell"
        
        // Configure the cell...
        let sectionIndex = indexPath.section
        let rowIndex = indexPath.row
        let _sections = self.sections as NSArray
        let section = _sections.objectAtIndex(sectionIndex) as! NSDictionary
        let rows = section.objectForKey("rows") as! NSArray
        let row = rows.objectAtIndex(rowIndex) as! NSDictionary
        
        // Cell type
        let cellClassName = row.valueForKey("class") as! String
        var cell = tableView.dequeueReusableCellWithIdentifier(cellClassName) as? SuperDBEditCell
        
        if cell == nil {
            switch cellClassName{
            case "SuperDBDateCell":
                cell = SuperDBDateCell(style: .Value2, reuseIdentifier: cellIdentifier)
            case "SuperDBPickerCell":
                cell = SuperDBPickerCell(style: .Value2, reuseIdentifier: cellIdentifier)
            case "SuperDBColorCell":
                cell = SuperDBColorCell(style: .Value2, reuseIdentifier: cellClassName)
            default:
                cell = SuperDBEditCell(style: .Value2, reuseIdentifier: cellIdentifier)
            }
            
        }
        
        
        let dataKey = row.objectForKey("key") as! String!
        cell?.key = dataKey
        cell?.label.text = row.objectForKey("label") as! String!
        
        
        if let _values = row["values"] as? NSArray {
            (cell as! SuperDBPickerCell).values = _values as [AnyObject]
        }
        
        let theData:AnyObject? = self.hero.valueForKey(dataKey)
        cell?.value = theData
        
        if let _theDate = theData as? NSDate {
            cell?.textField.text = __dateFormatter.stringFromDate(_theDate)
        }else if let _color = theData as? UIColor {
            if let _cell = cell as? SuperDBColorCell {
                _cell.value = _color
                _cell.textField.attributedText = _cell.attributedColorString
            }
        } else {
            cell?.textField.text = theData?.description
        }
        
        cell?.hero = self.hero
        
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
        
        for cell in self.tableView.visibleCells {
            let _cell = cell as! SuperDBEditCell
            if _cell.isEditable() {
                self.hero.setValue(_cell.value, forKey: _cell.key)
            }
            
            var error: NSError?
            do {
                try self.hero.managedObjectContext?.save()
            } catch let error1 as NSError {
                error = error1
            }
            if error != nil{
                print("Error saving : \(error?.localizedDescription)")
            }
        }
        
        self.tableView.reloadData()
    }
    
    func cancel() {
        self.setEditing(false, animated:true)
    }
}
