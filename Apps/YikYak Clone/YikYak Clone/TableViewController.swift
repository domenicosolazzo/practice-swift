
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
    
    override init(style: UITableViewStyle, className: String?) {
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
        let settings = UIAlertAction(title: "Settings", style: UIAlertActionStyle.Default) { (action) -> Void in
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
        locationManager.desiredAccuracy = 1000
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject!) -> PFTableViewCell? {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! TableViewCell
        var message = ""
        var score = 0
        var replyCount = 0
        if let obj = object {
            message = (obj.valueForKey("text") as? String)!
            score = obj.valueForKey("count") as! Int
            replyCount = object.objectForKey("replies") as! Int
        }
        cell.yakText.text = message
        cell.yakText.numberOfLines = 0
        cell.count.text = "\(score)"
        cell.time.text = "\((indexPath.row + 1) * 3)m ago"
        cell.replies.text = "\(replyCount) replies"
        return cell
    }
    
    @IBAction func topButton(sender: AnyObject) {
        // identify the point in the tableview the touch happened and convert it to indexPath using indexPathForRowAtPoint function.
        let hitPoint = sender.convertPoint(CGPointZero, toView: self.tableView)
        let hitIndex = self.tableView.indexPathForRowAtPoint(hitPoint)
        let object = objectAtIndexPath(hitIndex)
        object!.incrementKey("count")
        object?.saveInBackgroundWithBlock({ (success:Bool, error:NSError?) -> Void in
            if let theError = error{
                NSLog("Error saving: \(theError)")
                
            }
        })
        self.tableView.reloadData()
        NSLog("Top Index Path \(hitIndex?.row)")
    }
    
    @IBAction func bottomButton(sender: AnyObject) {
        // identify the point in the tableview the touch happened and convert it to indexPath using indexPathForRowAtPoint function.
        let hitPoint = sender.convertPoint(CGPointZero, toView: self.tableView)
        let hitIndex = self.tableView.indexPathForRowAtPoint(hitPoint)
        let object = objectAtIndexPath(hitIndex)
        object!.incrementKey("count", byAmount: -1)
        object!.saveInBackgroundWithBlock { (success:Bool, error:NSError?) -> Void in
            if let theError = error{
                NSLog("Error saving: \(theError)")
            }
        }
        self.tableView.reloadData()
        NSLog("Bottom Index Path \(hitIndex?.row)")
    }
    
    //- MARK: Parse
    override func queryForTable() -> PFQuery {
        let query = PFQuery(className: "Yak")
        if let queryLoc = currLocation {
            query.whereKey("location", nearGeoPoint: PFGeoPoint(latitude: queryLoc.latitude, longitude: queryLoc.longitude), withinMiles: 10)
            query.limit = 200;
            query.orderByDescending("createdAt")
        } else {
            /* Decide on how the application should react if there is no location available */
            query.whereKey("location", nearGeoPoint: PFGeoPoint(latitude: 37.411822, longitude: -121.941125), withinMiles: 10)
            query.limit = 200;
            query.orderByDescending("createdAt")
        }
        
        return query
    }
    

    override func objectAtIndexPath(indexPath: NSIndexPath!) -> PFObject? {
        var obj : PFObject? = nil
        if let objects = self.objects{
            if(indexPath.row < self.objects!.count){
                obj = self.objects![indexPath.row] as? PFObject
            }
            
            return obj
        }
        return nil
    }

    
    //- MARK: Core Location
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        alert("Cannot fetch your location")
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
        if(locations.count > 0){
            let location = locations[0] 
            print(location.coordinate)
            currLocation = location.coordinate
        } else {
            alert("Cannot fetch your location")
        }
    }


}
