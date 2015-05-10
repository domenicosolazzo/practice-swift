//
//  ViewController.swift
//  Enabling Swipe deletion of TableViewCells
//
//  Created by Domenico Solazzo on 10/05/15.
//  License MIT
//

import UIKit

class ViewController: UIViewController,
        UITableViewDelegate, UITableViewDataSource {
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
        
        // Create the table view
        tableView = UITableView(frame: view.bounds, style: UITableViewStyle.Plain)
        
        if let theTableView = tableView{
            // Register the TableViewCell
            theTableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "identifier")
            
            theTableView.dataSource = self
            theTableView.delegate = self
            theTableView.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
            
            // Add the table view as subview
        }
    }
}

