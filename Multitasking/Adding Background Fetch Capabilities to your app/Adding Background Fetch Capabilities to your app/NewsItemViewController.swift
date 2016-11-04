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
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    deinit{
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* Listen when news items are changed */
        NotificationCenter.default.addObserver(self,
            selector: #selector(NewsItemViewController.handleNewsItemsChanged(_:)),
            name: NSNotification.Name(rawValue: appDelegate.newsItemsChangedNotification()),
            object: nil)
        
        /* Handle what we need to do when the app comes back to the
        foreground */
        NotificationCenter.default.addObserver(self,
            selector: #selector(NewsItemViewController.handleAppIsBroughtToForeground(_:)),
            name: NSNotification.Name.UIApplicationWillEnterForeground,
            object: nil)
    }
    
    //- MARK: Helpers
    /* If there is need to reload after we come back to the foreground,
    do it here */
    func handleAppIsBroughtToForeground(_ notification: Notification){
        if mustReloadView{
            print("\(#function): Need to reload the table view")
            tableView.reloadData()
        }
    }
    
    /* We are being told that new news items are available.
    Reload the table view */
    func handleNewsItemsChanged(_ notification: Notification) {
        if self.isBeingPresented{
            print("\(#function): Need to reload the table view")
            tableView.reloadData()
        } else {
            print("\(#function): Need to reload the table view when it will come back in foreground")
            mustReloadView = true
        }
    }
    
    //- MARK: TableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) 
        cell.textLabel!.text = newsItems[(indexPath as NSIndexPath).row].text
        cell.detailTextLabel!.text = "\(newsItems[(indexPath as NSIndexPath).row].date)"
        return cell
    }
}
