//
//  ViewController.swift
//  Displaying directions on the Map
//
//  Created by Domenico Solazzo on 19/05/15.
//  License MIT
//

import UIKit
import MapKit

class ViewController: UIViewController,
    MKMapViewDelegate, CLLocationManagerDelegate  {

    var mapView: MKMapView!
    var locationManager: CLLocationManager?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        mapView = MKMapView()
    }
    
    /* Set up the map and add it to our view */
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.mapType = .standard
        mapView.frame = view.frame
        mapView.delegate = self
        view.addSubview(mapView)
    }
    
    
    //- MARK: Helper methods
    func displayAlertWithTitle(_ title: String, message: String){
        let controller = UIAlertController(title: title,
            message: message,
            preferredStyle: .alert)
        
        controller.addAction(UIAlertAction(title: "OK",
            style: .default,
            handler: nil))
        
        present(controller, animated: true, completion: nil)
        
    }
    
    //- MARK: LocationManager
    func locationManager(_ manager: CLLocationManager,
        didChangeAuthorization status: CLAuthorizationStatus){
            
            print("The authorization status of location " +
                "services is changed to: ", terminator: "")
            
            switch CLLocationManager.authorizationStatus(){
            case .denied:
                print("Denied")
            case .notDetermined:
                print("Not determined")
            case .restricted:
                print("Restricted")
            default:
                print("Authorized")
                provideDirections()
            }
            
    }
    
    func provideDirections(){
        let destination = "Godsgatan, Norrköping, Sweden"
        let a = CLGeocoder()
        CLGeocoder().geocodeAddressString(destination){ placemarks, error in
            
                if error != nil{
                    /* Handle the error here perhaps by displaying an alert */
                } else {
                    let request = MKDirectionsRequest()
                    request.setSource = MKMapItem.mapItemForCurrentLocation()
                    
                    /* Convert the CoreLocation destination
                    placemark to a MapKit placemark */
                    let placemark = placemarks?[0] as! CLPlacemark
                    let destinationCoordinates =
                    placemark.location.coordinate
                    /* Get the placemark of the destination address */
                    let destination = MKPlacemark(coordinate:
                        destinationCoordinates,
                        addressDictionary: nil)
                    
                    request.setDestination = MKMapItem(placemark: destination)
                    
                    /* Set the transportation method to automobile */
                    request.transportType = .automobile
                    
                    /* Get the directions */
                    let directions = MKDirections(request: request)
                    directions.calculateDirectionsWithCompletionHandler{
                        (response: MKDirectionsResponse!, error: NSError!) in
                        
                        /* You can manually parse the response, but in
                        here we will take a shortcut and use the Maps app
                        to display our source and
                        destination. We didn't have to make this API call at all,
                        as we already had the map items before, but this is to
                        demonstrate that the directions response contains more
                        information than just the source and the destination. */
                        
                        /* Display the directions on the Maps app */
                        let launchOptions = [
                            MKLaunchOptionsDirectionsModeKey:
                        MKLaunchOptionsDirectionsModeDriving]
                        
                        MKMapItem.openMapsWithItems(
                            [response.source, response.destination],
                            launchOptions: launchOptions)
                    } as! MKDirectionsHandler                     
                }
        }
    }
    
    /* Add the pin to the map and center the map around the pin */
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        /* Are location services available on this device? */
        if CLLocationManager.locationServicesEnabled(){
            
            /* Do we have authorization to access location services? */
            switch CLLocationManager.authorizationStatus(){
            case .denied:
                /* No */
                displayAlertWithTitle("Not Determined",
                    message: "Location services are not allowed for this app")
            case .notDetermined:
                /* We don't know yet, we have to ask */
                locationManager = CLLocationManager()
                if let manager = self.locationManager{
                    manager.delegate = self
                    manager.requestWhenInUseAuthorization()
                }
            case .restricted:
                /* Restrictions have been applied, we have no access
                to location services */
                displayAlertWithTitle("Restricted",
                    message: "Location services are not allowed for this app")
            default:
                provideDirections()
            }
            
            
        } else {
            /* Location services are not enabled.
            Take appropriate action: for instance, prompt the
            user to enable the location services */
            print("Location services are not enabled")
        }
        
    }
    
    
}

