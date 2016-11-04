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
        _ hostViewController: UIViewController,
        title:String,
        message: String,
        buttonTitle: String){
            let controller = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
            
            controller.addAction(UIAlertAction(title: buttonTitle, style: UIAlertActionStyle.default, handler: nil))
            
            hostViewController.present(controller, animated: true, completion: nil)
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Adding the edit button
        self.navigationItem.leftBarButtonItem = editButtonItem
        // Reload the data
        tableView.reloadData()
    }
    
    //- MARK: TableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Disable the edit button when there are no rows
        let numberOfRows =  homeManager.homes.count
        
        if numberOfRows == 0 && isEditing{
            setEditing(!isEditing, animated: true)
        }
        
        editButtonItem.isEnabled = (numberOfRows > 0)
        return numberOfRows
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewValues.identifier, for: indexPath) 
        
        // Home
        let home = homeManager.homes[(indexPath as NSIndexPath).row] 
        
        cell.textLabel!.text = home.name
        return cell
    }
    
    // Intercept the delete action
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete{
            // Take the home in that row
            let home = homeManager.homes[(indexPath as NSIndexPath).row] 
            
            // Remove the home
            homeManager.removeHome(HMHome, completionHandler: { (NSError?) in
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
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        /* Don't let the user add another home while they are editing
        the list of homes. This makes sure the user focuses on the task
        at hand */
        self.navigationItem.rightBarButtonItem?.isEnabled = !editing
    }
    
    //- MARK: HomeKit
    func homeManagerDidUpdateHomes(_ manager: HMHomeManager) {
        // As soon the home manager has loaded the list of homes, we will reload the table view
        tableView.reloadData()
    }
    
    
    
    func homeManagerDidUpdatePrimaryHome(_ manager: HMHomeManager) {
        tableView.reloadData()
    }
    
    //- MARK: Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifier{
            let controller = segue.destination as! AddHomeViewController
            controller.homeManager = homeManager
        }
        super.prepare(for: segue, sender: sender)
    }
}
