//
//  ViewController.swift
//  Populate TableViews
//
//  Created by Domenico Solazzo on 10/05/15.
//  License MIT
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    var tableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView(frame: view.bounds, style: UITableViewStyle.Plain)
        
        if let theTableView = tableView{
            // It takes a class name that denotes the type of object that you want your table view to load when it renders each cell (subclass of UITableViewCell) and a cell identifier.
            theTableView.registerClass(UITableViewCell.classForCoder(),
                forCellReuseIdentifier: "identifier")
            
            // It takes an object that conform to UITableViewDataSource
            theTableView.dataSource = self
            theTableView.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
            
            // Add the table view as subview
            view.addSubview(theTableView)
        }
    }
    
    // Number of sections in the table view
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3 // Default is 1
    }
    
    // How many rows for each section
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch(section){
        case 0:
            return 3
        case 1:
            return 5
        case 2:
            return 8
        default:
            return 0
        }
    }
    
    // Return each cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("identifier", forIndexPath: indexPath) as! UITableViewCell
        
        cell.textLabel.text = "Section \(indexPath.section) -> Row \(indexPath.row)"
        return cell
    }
    
    // Prefers status bar hidden
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}

