
import UIKit

class SearchResultsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, APIControllerProtocol {
                            
    @IBOutlet var appTableView: UITableView
    var api: APIController = APIController()
    var tableData: NSArray = NSArray()
    
    
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
    
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "MyTestCell")
        
        var rowData: NSDictionary = self.tableData[indexPath.row] as NSDictionary
        cell.text = rowData["trackName"] as String
        
        
        var imgString = rowData["artworkUrl60"] as String
        var imgURL: NSURL = NSURL(string: imgString)
        var imgData: NSData = NSData(contentsOfURL: imgURL)
        cell.image = UIImage(data: imgData)
        
        var formattedPrice: NSString = rowData["formattedPrice"] as NSString
        cell.detailTextLabel.text = formattedPrice
        
        
        return cell
    }



}

