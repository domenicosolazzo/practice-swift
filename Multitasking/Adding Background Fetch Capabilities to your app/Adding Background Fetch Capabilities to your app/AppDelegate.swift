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
    
    func applicationDidFinishLaunching(_ application: UIApplication) {
        // Adding a news item as soon the app starts
        newsItems.append(NewsItem(date:Date(), text: "NewsItem 1"))
        
        // Set the background interval for fetching new content
        application.setMinimumBackgroundFetchInterval(UIApplicationBackgroundFetchIntervalMinimum)
        
    }
    
    /**
        It gets called in your app delegate when iOS wants your app 
        to fetch new content in the background. 
        Call the completion handler when you are done.
    **/
    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print("\(#function): Trying to fetch new items...")
        if (self.fetchItems()){
        
            completionHandler(UIBackgroundFetchResult.newData)
        }else{
            // If there is not data, you need to call it with .NoData parameter.
            completionHandler(UIBackgroundFetchResult.noData)
        }
    }
    
    // Name of the notification when a news item is available
    func newsItemsChangedNotification() -> String{
        return "\(#function)"
    }
    
    /* Mock function: Returns true if it could get some news items from the server */
    func fetchItems() -> Bool{
        print("\(#function): Looking for new items...")
        let coin = arc4random_uniform(2) // 0 or 1
        if(coin != 1){
            print("\(#function): No data")
            return false
        }
        
        print("\(#function): New data is available...")
        // Generate new item
        let item = NewsItem(date: Date(), text: "News Item \(newsItems.count + 1)")
        newsItems.append(item)
        
        /* Send a notification to observers telling them that a news item
        is now available */
        let notificationName = self.newsItemsChangedNotification()
        NotificationCenter.default.post(name: Notification.Name(rawValue: notificationName), object: nil)
        return true
        
    }
}

