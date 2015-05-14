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
}
