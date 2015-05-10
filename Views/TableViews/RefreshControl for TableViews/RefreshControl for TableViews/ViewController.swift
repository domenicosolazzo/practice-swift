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
    
    //- MARK: Refresh Control
    func handleRefresh(paramSender: AnyObject){
        /* Put a bit of delay between when the refresh control is released
        and when we actually do the refreshing to make the UI look a bit
        smoother than just doing the update without the animation */
        let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64(NSEC_PER_SEC))
        
        // Dispatch after..
        dispatch_after(popTime, dispatch_get_main_queue()){
            /* Add the current date to the list of dates that we have
            so that when the table view is refreshed, a new item appears
            on the screen so that the user sees the difference between
            the before and the after of the refresh */
            self.allTimes.append(NSDate())
            self.refreshControl!.endRefreshing()
            let indexPathOfNewRow = NSIndexPath(forRow: self.allTimes.count - 1, inSection: 0)
            self.tableView!.insertRowsAtIndexPaths([indexPathOfNewRow], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    
}

