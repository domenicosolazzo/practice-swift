import UIKit
import MediaPlayer
import QuartzCore

class DetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, APIControllerProtocol{
    @lazy var api: APIController = APIController(delegate: self)
    var album: Album?
    
    @IBOutlet var albumTitle : UILabel
    @IBOutlet var cover : UIImageView
    @IBOutlet var tracksTableView: UITableView
    
    var tracks: Track[] = []
    
    var mediaPlayer = MPMoviePlayerController()
    
    init(coder aDecoder: NSCoder!){
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        //self.albumTitle.text = album?.title
        
        //var url = NSURL(string:self.album?.largeImageURL)
        //var data = NSData(contentsOfURL:url)
        //self.cover.image = UIImage(data: data)
        if self.album?.collectionId?{
            self.api.lookupAlbum(self.album!.collectionId!)
        }
        
    }

    func didReceiveAPIResults(results: NSDictionary) {
        if let allResults = results["results"] as? NSDictionary[] {
            for trackInfo in allResults {
                // Create the track
                if let kind = trackInfo["kind"] as? String {
                    if kind=="song" {
                        var track = Track(dict: trackInfo)
                        tracks.append(track)
                    }
                }
            }
        }
        dispatch_async(dispatch_get_main_queue(), {
            self.tracksTableView.reloadData()
            })
    }
    

    
    
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        var cell = tableView.dequeueReusableCellWithIdentifier("TrackCell") as TrackCell
        
        var track = tracks[indexPath.row]
        cell.titleLabel.text = track.title
        println(track.title)
        cell.playIcon.text = "▶️"
        
        return cell

    }
    
    func tableView(tableView: UITableView!, willDisplayCell cell: UITableViewCell!, forRowAtIndexPath indexPath: NSIndexPath!) {
        cell.layer.transform = CATransform3DMakeScale(0.1,0.1,1)
        UIView.animateWithDuration(0.25, animations: {
            cell.layer.transform = CATransform3DMakeScale(1,1,1)
            })
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        var track = tracks[indexPath.row]
        mediaPlayer.stop()
        mediaPlayer.contentURL = NSURL(string: track.previewUrl)
        mediaPlayer.play()
        if let cell = tableView.cellForRowAtIndexPath(indexPath) as? TrackCell {
            cell.playIcon.text = "▪️"
        }
    }
}