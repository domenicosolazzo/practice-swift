
//
//  TableViewController.swift
//  YikYak Clone
//
//  Created by Domenico on 07/06/15.
//  Copyright (c) 2015 Domenico. All rights reserved.
//

import UIKit
import CoreLocation


class TableViewController: PFQueryTableViewController, CLLocationManagerDelegate {

    let yaks = ["Getting Started with building a Yik Yak Clone in Swift","Xcode 6 Tutorial using Autolayouts",
        "In this tutorial you will also learn how to talk to Parse Backend", "Learning Swift by building real world applications", "Subscribe to get more info"]

    let locationManager = CLLocationManager()
    var currLocation : CLLocationCoordinate2D?
    
    override init!(style: UITableViewStyle, className: String!) {
        super.init(style: style, className: className)
    }
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.parseClassName = "Yak"
        self.textKey = "text"
        self.pullToRefreshEnabled = true
        self.objectsPerPage = 200
        
    }

    private func alert(message : String) {
        let alert = UIAlertController(title: "Oops something went wrong.", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let action = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
        let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
        let settings = UIAlertAction(title: "Settings", style: UIAlertActionStyle.Default) { (action) -&gt; Void in
            UIApplication.sharedApplication().openURL(NSURL(string: UIApplicationOpenSettingsURLString)!)
            return
        }
        alert.addAction(settings)
        alert.addAction(action)
        self.presentViewController(alert, animated: true, completion: nil)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.tableView.estimatedRowHeight = 60
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.yaks.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! TableViewCell
        cell.yakText.text = yaks[indexPath.row]
        cell.count.text = "\((indexPath.row + 1) * 5)"
        cell.time.text = "\((indexPath.row + 1) * 3)m ago"
        cell.replies.text = "\((indexPath.row + 1) * 1) replies"
        return cell
    }
    

    @IBAction func topButton(sender: AnyObject) {
        // identify the point in the tableview the touch happened and convert it to indexPath using indexPathForRowAtPoint function.
        let hitPoint = sender.convertPoint(CGPointZero, toView: self.tableView)
        let hitIndex = self.tableView.indexPathForRowAtPoint(hitPoint)
        
        NSLog("Top Index Path \(hitIndex?.row)")
    }
    
    @IBAction func bottomButton(sender: AnyObject) {
        // identify the point in the tableview the touch happened and convert it to indexPath using indexPathForRowAtPoint function.
        let hitPoint = sender.convertPoint(CGPointZero, toView: self.tableView)
        let hitIndex = self.tableView.indexPathForRowAtPoint(hitPoint)
        NSLog("Bottom Index Path \(hitIndex?.row)")
    }

}
