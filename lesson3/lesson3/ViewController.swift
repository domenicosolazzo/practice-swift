//
//  ViewController.swift
//  lesson3
//
//  Created by Domenico Solazzo on 6/10/14.
//  Copyright (c) 2014 Domenico Solazzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var appTableView: UITableView
    var data: NSMutableData = NSMutableData()
    var tableData: NSArray = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        searchItunesFor("Apple")
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func connection(didReceiveResponse: NSURLConnection!, didReceiveResponse response: NSURLResponse!) {
        // Received a new request, clear out the data object
        self.data = NSMutableData()
    }
    
    func connection(connection: NSURLConnection!, didReceiveData data: NSData!) {
        // Append the received chunk of data to our data object
        self.data.appendData(data)
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection!) {
        // Request complete, self.data should now hold the resulting info
        // Convert the retrieved data in to an object through JSON deserialization
        var err: NSError
        var jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options:    NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
        
        if jsonResult.count>0 && jsonResult["results"].count>0 {
            var results: NSArray = jsonResult["results"] as NSArray
            self.tableData = results
            self.appTableView.reloadData()
            
        }
    }
    
    func searchItunesFor(searchTerm: String){
        var itunesSearchTerm = searchTerm.stringByReplacingOccurrencesOfString(" ", withString: "+", options: NSStringCompareOptions.CaseInsensitiveSearch, range:nil)
        var escapedItunesSearchTerm = itunesSearchTerm.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        var urlPath = "https://itunes.apple.com/search?term=\(escapedItunesSearchTerm)&media=software"
        var url: NSURL = NSURL(string: urlPath)
        var request: NSURLRequest = NSURLRequest(URL: url)
        var connection = NSURLConnection(request: request, delegate:self, startImmediately:false)
        
        println("Start ITUNES search at \(urlPath)")
        connection.start()
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "MyTestCell")
        
        var rowData: NSDictionary = self.tableData[indexPath.row] as NSDictionary
        cell.text = rowData["trackName"] as String
        
        // Thumbnail: check for artworkUrl60 in the json result
        var imgString = rowData["artworkUrl60"] as String
        var imgURL: NSURL = NSURL(string: imgString)
        var imgData: NSData = NSData(contentsOfURL: imgURL)
        cell.image = UIImage(data: imgData)
        
        // Format price
        var formattedPrice: NSString = rowData["formattedPrice"] as NSString
        cell.detailTextLabel.text = formattedPrice
        
        
        
        return cell
    }

}

