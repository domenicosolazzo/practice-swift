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
}
