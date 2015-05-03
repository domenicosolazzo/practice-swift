import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
                            
    @IBOutlet var theMap: MKMapView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // User tracking mode in iOS
        self.theMap.setUserTrackingMode(MKUserTrackingMode.Follow, animated: true);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

