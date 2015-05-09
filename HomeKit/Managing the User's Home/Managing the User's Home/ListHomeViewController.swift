//
//  ListHomeViewController.swift
//  Managing the User's Home
//
//  Created by Domenico Solazzo on 09/05/15.
//  License MIT
//

import UIKit
import HomeKit

extension UIAlertController{
    class func showAlertControllerOnHostController(
        hostViewController: UIViewController,
        title:String,
        message: String,
        buttonTitle: String){
            let controller = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
            
            controller.addAction(UIAlertAction(title: buttonTitle, style: UIAlertActionStyle.Default, handler: nil))
            
            hostViewController.presentViewController(controller, animated: true, completion: nil)
    }
}


class ListHomeViewController: UITableViewController, HMHomeManagerDelegate {
    // Segue identifier
    let segueIdentifier = "addHome"
    
    struct TableViewValues {
        static let identifier = "Cell"
    }
    
    // Home manager
    lazy var homeManager: HMHomeManager = {
        let manager = HMHomeManager()
        manager.delegate = self
        return manager
    }()
    
    //- MARK: TableView
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeManager.homes.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(TableViewValues.identifier, forIndexPath: indexPath) as! UITableViewCell
        
        // Home
        let home = homeManager.homes[indexPath.row] as! HMHome
        
        cell.textLabel!.text = home.name
        return cell
    }
    
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        /* Don't let the user add another home while they are editing
        the list of homes. This makes sure the user focuses on the task
        at hand */
        self.navigationItem.rightBarButtonItem?.enabled = !editing
    }
    
    //- MARK: HomeKit
    func homeManagerDidUpdateHomes(manager: HMHomeManager) {
        // As soon the home manager has loaded the list of homes, we will reload the table view
        tableView.reloadData()
    }
    
    //- MARK: Segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == segueIdentifier{
            let controller = segue.destinationViewController as! AddHomeViewController
            controller.homeManager = homeManager
        }
        super.prepareForSegue(segue, sender: sender)
    }
}
