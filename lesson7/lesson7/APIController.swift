import UIKit

protocol APIControllerProtocol {
    func didRecieveAPIResults(results: NSDictionary)
}

class APIController: NSObject {
    var delegate: APIControllerProtocol?
    
    
    func searchItunesFor(searchTerm: String){
        var itunesSearchTerm = searchTerm.stringByReplacingOccurrencesOfString(" ", withString: "+", options: NSStringCompareOptions.CaseInsensitiveSearch, range:nil)
        var escapedItunesSearchTerm = itunesSearchTerm.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        var urlPath = "https://itunes.apple.com/search?term=\(escapedItunesSearchTerm)&media=software"
        var url: NSURL = NSURL(string: urlPath)
        var request: NSURLRequest = NSURLRequest(URL: url)
        
        
    }
    
    
}
