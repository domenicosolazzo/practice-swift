//
//  ViewController.swift
//  RefreshControl for TableViews
//
//  Created by Domenico Solazzo on 10/05/15.
//  License MIT
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    
    var tableView: UITableView?
    var refreshControl: UIRefreshControl?
    // Data
    var allTimes = [NSDate]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView(frame: view.bounds, style: UITableViewStyle.Plain)
        if let theTableView = tableView {
            theTableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "identifier")
            
            theTableView.dataSource = self
            theTableView.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
            
            /** Refresh control */
            refreshControl = UIRefreshControl()
            // Add target to the refresh control
            refreshControl?.addTarget(self, action: "handleRefresh:", forControlEvents: UIControlEvents.ValueChanged)
            
            // Adding the refresh control as subview of the table view
            theTableView.addSubview(refreshControl!)
            
            self.view.addSubview(theTableView)
        }
    }
    
    //- MARK: UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("identifier", forIndexPath: indexPath) as! UITableViewCell
        cell.textLabel!.text = "Cell \(indexPath.row)"
        return cell
    }
    
}

