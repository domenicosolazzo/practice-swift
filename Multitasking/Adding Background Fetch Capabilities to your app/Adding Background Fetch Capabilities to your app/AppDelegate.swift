//
//  AppDelegate.swift
//  Adding Background Fetch Capabilities to your app
//
//  Created by Domenico Solazzo on 14/05/15.
//  License MIT
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    // News items
    var newsItems = [NewsItem]()
    
    func applicationDidFinishLaunching(application: UIApplication) {
        // Adding a news item as soon the app starts
        newsItems.append(NewsItem(date:NSDate(), text: "NewsItem 1"))
        
        // Set the background interval for fetching new content
        application.setMinimumBackgroundFetchInterval(UIApplicationBackgroundFetchIntervalMinimum)
        
    }
    
    // Name of the notification when a news item is available
    func newsItemsChangedNotification() -> String{
        return "\(__FUNCTION__)"
    }
    
    /* Mock function: Returns true if it could get some news items from the server */
    func fetchItems() -> Bool{
        if(arc4random_uniform(2) != 1){
            return false
        }
        
        // Generate new item
        let item = NewsItem(date: NSDate(), text: "News Item \(newsItems.count + 1)")
        newsItems.append(item)
        
        /* Send a notification to observers telling them that a news item
        is now available */
        let notificationName = self.newsItemsChangedNotification()
        NSNotificationCenter.defaultCenter().postNotificationName(notificationName, object: nil)
        return true
        
    }
}

