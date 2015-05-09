//
//  ListHomeViewController.swift
//  Managing the User's Home
//
//  Created by Domenico Solazzo on 09/05/15.
//  License MIT
//

import UIKit
import HomeKit

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
        let cell = tableView.dequeueReusableCellWithIdentifier(TableViewValues.identifier, forIndexPath: indexPath) as UITableViewCell
        
        // Home
        let home = homeManager.homes[indexPath.row] as HMHome
        
        cell.textLabel.text = home.name
        return cell
    }
    
    //- MARK: HomeKit
    func homeManagerDidUpdateHomes(manager: HMHomeManager) {
        // As soon the home manager has loaded the list of homes, we will reload the table view
        tableView.reloadData()
    }
}
