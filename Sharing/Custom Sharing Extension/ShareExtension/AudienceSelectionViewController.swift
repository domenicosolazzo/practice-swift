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
    @objc optional func audienceSelectionViewController(
        _ sender: AudienceSelectionViewController,
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
        super.init(coder: aDecoder)!
    }
    
    override init(style: UITableViewStyle) {
        super.init(style: style)
        tableView.register(UITableViewCell.classForCoder(),
            forCellReuseIdentifier: TableViewValues.identifier)
        title = "Choose Audience"
    }
    
    override func tableView(_ tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
            return Audience.allValues.count
    }
    
    override func tableView(_ tableView: UITableView,
        cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: TableViewValues.identifier,
                for: indexPath) 
            
            let text = Audience.allValues[(indexPath as NSIndexPath).row].rawValue
            
            cell.textLabel!.text = text
            
            if text == audience{
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
            
            return cell
    }
    
    override func tableView(_ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath) {
            
            if let theDelegate = delegate{
                let selectedAudience = Audience.allValues[(indexPath as NSIndexPath).row].rawValue
                theDelegate.audienceSelectionViewController!(self,
                    selectedValue: selectedAudience)
                
            }
            
    }
    
}
