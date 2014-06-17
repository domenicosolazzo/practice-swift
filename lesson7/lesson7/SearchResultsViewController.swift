

import UIKit

class SearchResultsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, APIControllerProtocol {
    
    @IBOutlet var appTableView: UITableView
    var api: APIController = APIController()
    var tableData: NSArray = NSArray()
    // Image Cache
    var imageCache = NSMutableDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.api.delegate = self
        api.searchItunesFor("Apple")
        
    }
    
    func didRecieveAPIResults(results: NSDictionary) {
        if results.count>0 {
            self.tableData = results["results"] as NSArray
            self.appTableView.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!){
        // Get the row data for the selected row
        var rowData: NSDictionary = self.tableData[indexPath.row] as NSDictionary
        
        var cellText: String? = rowData["trackName"] as? String
        var formattedPrice: String = rowData["formattedPrice"] as String
        
        var alert: UIAlertView = UIAlertView()
        alert.title = cellText
        alert.message = formattedPrice
        alert.addButtonWithTitle("OK")
        alert.show()
        
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        // Optimizing the cell creation
        let kIdentifierCell: String = "SearchResultCell"
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(kIdentifierCell) as UITableViewCell
        
        
        var rowData: NSDictionary = self.tableData[indexPath.row] as NSDictionary
        let cellText: String? = rowData["trackName"] as? String
        cell.text = cellText
        cell.image = UIImage(named: "Blank52")
        
        var formattedPrice: NSString = rowData["formattedPrice"] as NSString
        
        
        // Call a background thread using GCD API
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0),{
            // Jump in a background thread to get the image for this item
            var urlString = rowData["artworkUrl60"] as String
            
            // Check if the image was cached
            var image : UIImage? = self.imageCache.valueForKey(urlString) as? UIImage
            
            if( !image? ){
                // If the image does not exist, we must download it
                var imageUrl = NSURL(string: urlString)
                
                // Download a NSData representation of the image
                var request: NSURLRequest = NSURLRequest(URL:imageUrl)
                
                var urlConnection: NSURLConnection = NSURLConnection(request: request, delegate: self)
                
                NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse!,data: NSData!,error: NSError!) -> Void in
                    if !error? {
                        image = UIImage(data: data)
                        
                        // Store the image in to our cache
                        self.imageCache.setValue(image, forKey: urlString)
                        cell.image = image
                    }
                    else {
                        println("Error: \(error.localizedDescription)")
                    }
                    })
                
            }else{
                cell.image = image
            }
            
            })
        
        cell.detailTextLabel.text = formattedPrice
        
        
        return cell
    }
    
    
    
}

