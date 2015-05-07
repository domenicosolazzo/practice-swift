//
//  AudienceSelectionViewController.swift
//  Custom Sharing Extension
//
//  Created by Domenico Solazzo on 07/05/15.
//  License MIT
//

import UIKit

@objc(AudienceSelectionViewControllerDelegate)
protocol AudienceSelectionViewControllerDelegate{
    optional func audienceSelectionViewController(
        sender: AudienceSelectionViewController,
        selectedValue: String)
}

class AudienceSelectionViewController: UITableViewController {
    
    struct TableViewValues{
        static let identifier = "Cell"
    }
    
    enum Audience: String{
        case Everyone = "Everyone"
        case Family = "Family"
        case Friends = "Friends"
        static let allValues = [Everyone, Family, Friends]
    }
    
    var delegate: AudienceSelectionViewControllerDelegate?
    
    var audience = Audience.Everyone.rawValue
    
    class func defaultAudience() -> String{
        return Audience.Everyone.rawValue
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewStyle) {
        super.init(style: style)
        tableView.registerClass(UITableViewCell.classForCoder(),
            forCellReuseIdentifier: TableViewValues.identifier)
        title = "Choose Audience"
    }
    
    override func tableView(tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
            return Audience.allValues.count
    }
    
    override func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCellWithIdentifier(
                TableViewValues.identifier,
                forIndexPath: indexPath) as! UITableViewCell
            
            let text = Audience.allValues[indexPath.row].rawValue
            
            cell.textLabel!.text = text
            
            if text == audience{
                cell.accessoryType = .Checkmark
            } else {
                cell.accessoryType = .None
            }
            
            return cell
    }
    
    override func tableView(tableView: UITableView,
        didSelectRowAtIndexPath indexPath: NSIndexPath) {
            
            if let theDelegate = delegate{
                let selectedAudience = Audience.allValues[indexPath.row].rawValue
                theDelegate.audienceSelectionViewController!(self,
                    selectedValue: selectedAudience)
                
            }
            
    }
    
}
