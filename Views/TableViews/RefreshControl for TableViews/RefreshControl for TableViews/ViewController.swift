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
    var allTimes = [Date]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.allTimes.append(Date())
        tableView = UITableView(frame: view.bounds, style: UITableViewStyle.plain)
        if let theTableView = tableView {
            theTableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "identifier")
            
            theTableView.dataSource = self
            theTableView.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
            
            /* Create the refresh control */
            refreshControl = UIRefreshControl()
            refreshControl.addTarget(self,
                action: #selector(ViewController.handleRefresh(_:)),
                for: UIControlEvents.valueChanged)
          
            
            theTableView.addSubview(refreshControl)
            
            self.view.addSubview(theTableView)
        }
    }
    
    //- MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.allTimes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "identifier", for: indexPath) 
        cell.textLabel!.text = "\(allTimes[(indexPath as NSIndexPath).row])"
        return cell
    }
    
    //- MARK: Refresh Control
    func handleRefresh(_ refreshControl: UIRefreshControl){
        /* Put a bit of delay between when the refresh control is released
        and when we actually do the refreshing to make the UI look a bit
        smoother than just doing the update without the animation */
        print("Refreshing....")
        let popTime = DispatchTime.now() + Double(Int64(NSEC_PER_SEC)) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: popTime, execute: {
                
                /* Add the current date to the list of dates that we have
                so that when the table view is refreshed, a new item appears
                on the screen so that the user sees the difference between
                the before and the after of the refresh */
                self.allTimes.append(Date())
                self.refreshControl.endRefreshing()
                let indexPathOfNewRow = IndexPath(row: self.allTimes.count - 1,
                    section: 0)
                
                self.tableView!.insertRows(at: [indexPathOfNewRow],
                    with: .automatic)
                
        })

    }
    
}

