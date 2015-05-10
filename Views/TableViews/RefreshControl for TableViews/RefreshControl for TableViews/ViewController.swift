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
    var refreshControl: UIRefreshControl!
    // Data
    var allTimes = [NSDate]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.allTimes.append(NSDate())
        tableView = UITableView(frame: view.bounds, style: UITableViewStyle.Plain)
        if let theTableView = tableView {
            theTableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "identifier")
            
            theTableView.dataSource = self
            theTableView.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
            
            /* Create the refresh control */
            refreshControl = UIRefreshControl()
            refreshControl.addTarget(self,
                action: "handleRefresh:",
                forControlEvents: UIControlEvents.ValueChanged)
          
            
            theTableView.addSubview(refreshControl)
            
            self.view.addSubview(theTableView)
        }
    }
    
    //- MARK: UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.allTimes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("identifier", forIndexPath: indexPath) as! UITableViewCell
        cell.textLabel!.text = "\(allTimes[indexPath.row])"
        return cell
    }
    
    //- MARK: Refresh Control
    func handleRefresh(refreshControl: UIRefreshControl){
        /* Put a bit of delay between when the refresh control is released
        and when we actually do the refreshing to make the UI look a bit
        smoother than just doing the update without the animation */
        println("Refreshing....")
        let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64(NSEC_PER_SEC))
        dispatch_after(popTime,
            dispatch_get_main_queue(), {
                
                /* Add the current date to the list of dates that we have
                so that when the table view is refreshed, a new item appears
                on the screen so that the user sees the difference between
                the before and the after of the refresh */
                self.allTimes.append(NSDate())
                self.refreshControl.endRefreshing()
                let indexPathOfNewRow = NSIndexPath(forRow: self.allTimes.count - 1,
                    inSection: 0)
                
                self.tableView!.insertRowsAtIndexPaths([indexPathOfNewRow],
                    withRowAnimation: .Automatic)
                
        })

    }
    
}

