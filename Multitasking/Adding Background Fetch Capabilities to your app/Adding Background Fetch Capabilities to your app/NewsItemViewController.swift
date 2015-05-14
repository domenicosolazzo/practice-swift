//
//  NewsItemViewController.swift
//  Adding Background Fetch Capabilities to your app
//
//  Created by Domenico Solazzo on 14/05/15.
//  License MIT
//

import UIKit

class NewsItemViewController: UITableViewController {
    var mustReloadView = false
    
    /* News items are coming from the app delegate */
    var newsItems: [NewsItem]{
        return appDelegate.newsItems
    }
    
    var appDelegate: AppDelegate{
        return UIApplication.sharedApplication().delegate as! AppDelegate
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* Listen when news items are changed */
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "handleNewsItemsChanged:",
            name: appDelegate.newsItemsChangedNotification(),
            object: nil)
        
        /* Handle what we need to do when the app comes back to the
        foreground */
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "handleAppIsBroughtToForeground:",
            name: UIApplicationWillEnterForegroundNotification,
            object: nil)
    }
    
    //- MARK: Helpers
    /* If there is need to reload after we come back to the foreground,
    do it here */
    func handleAppIsBroughtToForeground(notification: NSNotification){
        if mustReloadView{
            tableView.reloadData()
        }
    }
    
    /* We are being told that new news items are available.
    Reload the table view */
    func handleNewsItemsChanged(notification: NSNotification) {
        if self.isBeingPresented(){
            tableView.reloadData()
        } else {
            mustReloadView = true
        }
    }
    
    //- MARK: TableView
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsItems.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        cell.textLabel!.text = newsItems[indexPath.row].text
        cell.detailTextLabel!.text = "\(newsItems[indexPath.row].date)"
        return cell
    }
}
