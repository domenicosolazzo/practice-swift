import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add the longitude and latitude
        var longitude:CLLocationDegrees = 98.3
        var latitude:CLLocationDegrees = 21.44
        
        // Latitude delta: The map will look more zoom-in
        var latDelta:CLLocationDegrees = 0.01
        // Longitude delta
        var longDelta:CLLocationDegrees = 0.01
        
        // It defines the latitude and longitude directions to show on a map.
        var spanCoordinate: MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
        
        // Set the location
        var myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        
        // Create a region
        var theRegion:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, spanCoordinate)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

