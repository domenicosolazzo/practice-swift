//
//  ViewController.swift
//  Enabling Swipe deletion of TableViewCells
//
//  Created by Domenico Solazzo on 10/05/15.
//  License MIT
//

import UIKit

class ViewController: UIViewController {
    var tableView: UITableView?
    
    var allRows:[String] = [String]()
    
    // ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Mock data
        for index in 1..<10{
            allRows.append("Row at index \(index)")
        }
        
        // Set the edit button 
        self.navigationItem.setLeftBarButtonItem(editButtonItem(), animated: true)
    }
}

