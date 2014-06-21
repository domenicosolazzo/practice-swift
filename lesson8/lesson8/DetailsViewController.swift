import UIKit

class DetailsViewController: UIViewController{
    var album: Album?
    
    @IBOutlet var albumTitle : UILabel
    @IBOutlet var cover : UIImageView
    @IBOutlet var tracksTableView: UITableView
    
    init(coder aDecoder: NSCoder!){
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.albumTitle.text = album?.title
        
        var url = NSURL(string:self.album?.largeImageURL)
        var data = NSData(contentsOfURL:url)
        self.cover.image = UIImage(data: data)
        
    }
}