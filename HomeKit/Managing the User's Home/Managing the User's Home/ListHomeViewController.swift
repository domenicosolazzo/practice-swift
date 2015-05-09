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
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // Adding the edit button
        self.navigationItem.leftBarButtonItem = editButtonItem()
    }
    
    //- MARK: TableView
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Disable the edit button when there are no rows
        let numberOfRows =  homeManager.homes.count
        
        if numberOfRows == 0 && editing{
            setEditing(!editing, animated: true)
        }
        
        editButtonItem().enabled = (numberOfRows > 0)
        return numberOfRows
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(TableViewValues.identifier, forIndexPath: indexPath) as! UITableViewCell
        
        // Home
        let home = homeManager.homes[indexPath.row] as! HMHome
        
        cell.textLabel!.text = home.name
        return cell
    }
    
    // Intercept the delete action
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete{
            // Take the home in that row
            let home = homeManager.homes[indexPath.row] as! HMHome
            
            // Remove the home
            homeManager.removeHome(home, completionHandler: {[weak self]
                (error:NSError!) -> Void in
                let strongSelf = self!
                
                if error != nil{
                    UIAlertController.showAlertControllerOnHostController(strongSelf,
                        title: "Error happened",
                        message: "\(error)",
                        buttonTitle: "OK")
                }else{
                    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
                }
            })
        }
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
