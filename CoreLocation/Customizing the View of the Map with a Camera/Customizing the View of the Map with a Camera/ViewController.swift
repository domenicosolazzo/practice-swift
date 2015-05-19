//
//  ViewController.swift
//  Customizing the View of the Map with a Camera
//
//  Created by Domenico Solazzo on 19/05/15.
//  License MIT
//

import UIKit
import MapKit

class ViewController: UIViewController,
    MKMapViewDelegate, CLLocationManagerDelegate{

    var mapView: MKMapView!
    var locationManager: CLLocationManager?
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        mapView = MKMapView()
    }
    
    
    /* Set up the map and add it to our view */
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.mapType = .Standard
        mapView.frame = view.frame
        mapView.delegate = self
        view.addSubview(mapView)
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        /* Are location services available on this device? */
        if CLLocationManager.locationServicesEnabled(){
            
            /* Do we have authorization to access location services? */
            switch CLLocationManager.authorizationStatus(){
            case .Denied:
                /* No */
                displayAlertWithTitle("Not Determined",
                    message: "Location services are not allowed for this app")
            case .NotDetermined:
                /* We don't know yet, we have to ask */
                locationManager = CLLocationManager()
                if let manager = locationManager{
                    manager.delegate = self
                    manager.requestWhenInUseAuthorization()
                }
            case .Restricted:
                /* Restrictions have been applied, we have no access
                to location services */
                displayAlertWithTitle("Restricted",
                    message: "Location services are not allowed for this app")
            default:
                showUserLocationOnMapView()
            }
            
            
        } else {
            /* Location services are not enabled.
            Take appropriate action: for instance, prompt the
            user to enable the location services */
            println("Location services are not enabled")
        }
    }
    
    //- MARK: Helper methods
    /* Just a little method to help us display alert dialogs to the user */
    func displayAlertWithTitle(title: String, message: String){
        let controller = UIAlertController(title: title,
            message: message,
            preferredStyle: .Alert)
        
        controller.addAction(UIAlertAction(title: "OK",
            style: .Default,
            handler: nil))
        
        presentViewController(controller, animated: true, completion: nil)
        
    }
    
    /* We will call this method when we are sure that the user has given
    us access to her location */
    func showUserLocationOnMapView(){
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .Follow
    }
}

