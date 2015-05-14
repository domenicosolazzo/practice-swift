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
    let newsItems: [NewsItem]{
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        return appDelegate.newsItems
    }
}
