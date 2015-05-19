//
//  ViewController.swift
//  Searching on a MapView
//
//  Created by Domenico Solazzo on 19/05/15.
//  License MIT
//

import UIKit
import MapKit

class ViewController: UIViewController,
        MKMapViewDelegate, CLLocationManagerDelegate {
    
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
    
    //- MARK: Location Manager
    func locationManager(manager: CLLocationManager!,
        didUpdateToLocation newLocation: CLLocation!,
        fromLocation oldLocation: CLLocation!){
            
            println("Latitude = \(newLocation.coordinate.latitude)")
            println("Longitude = \(newLocation.coordinate.longitude)")
            
    }
    
    func locationManager(manager: CLLocationManager!,
        didFailWithError error: NSError!){
            println("Location manager failed with error = \(error)")
    }
    
    /* The authorization status of the user has changed, we need to react
    to that so that if she has authorized our app to to view her location,
    we will accordingly attempt to do so */
    func locationManager(manager: CLLocationManager!,
        didChangeAuthorizationStatus status: CLAuthorizationStatus){
            
            print("The authorization status of location services is changed to: ")
            
            switch CLLocationManager.authorizationStatus(){
            case .Denied:
                println("Denied")
            case .NotDetermined:
                println("Not determined")
            case .Restricted:
                println("Restricted")
            default:
                showUserLocationOnMapView()
            }
            
    }
    
    /* We will call this method when we are sure that the user has given
    us access to her location */
    func showUserLocationOnMapView(){
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .Follow
    }
    
    //- MARK: MapView
    func mapView(mapView: MKMapView!,
        didFailToLocateUserWithError error: NSError!) {
            displayAlertWithTitle("Failed",
                message: "Could not get the user's location")
    }
    
    func mapView(mapView: MKMapView!,
        didUpdateUserLocation userLocation: MKUserLocation!) {
            
            let request = MKLocalSearchRequest()
            request.naturalLanguageQuery = "restaurants";
            
            let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            
            request.region = MKCoordinateRegion(
                center: userLocation.location.coordinate,
                span: span)
            
            let search = MKLocalSearch(request: request)
            
            search.startWithCompletionHandler{
                (response: MKLocalSearchResponse!, error: NSError!) in
                
                for item in response.mapItems as! [MKMapItem]{
                    
                    println("Item name = \(item.name)")
                    println("Item phone number = \(item.phoneNumber)")
                    println("Item url = \(item.url)")
                    println("Item location = \(item.placemark.location)")
                    
                }
                
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
}

