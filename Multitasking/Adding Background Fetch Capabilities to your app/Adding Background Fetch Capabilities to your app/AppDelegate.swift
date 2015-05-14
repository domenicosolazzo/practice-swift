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
}

