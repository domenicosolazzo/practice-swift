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
                if let manager = locationManager{
                    manager.delegate = self
                    manager.requestWhenInUseAuthorization()
                }
            case .restricted:
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
            print("Location services are not enabled")
        }
    }
    //- MARK: Location Manager
    func locationManager(_ manager: CLLocationManager,
        didFailWithError error: Error){
            print("Location manager failed with error = \(error)")
    }
    
    /* The authorization status of the user has changed, we need to react
    to that so that if she has authorized our app to to view her location,
    we will accordingly attempt to do so */
    func locationManager(_ manager: CLLocationManager,
        didChangeAuthorization status: CLAuthorizationStatus){
            
            print("The authorization status of location services is changed to: ", terminator: "")
            
            switch CLLocationManager.authorizationStatus(){
            case .denied:
                print("Denied")
            case .notDetermined:
                print("Not determined")
            case .restricted:
                print("Restricted")
            default:
                showUserLocationOnMapView()
            }
            
    }
    
    //- MARK: MapView
    func mapView(_ mapView: MKMapView,
        didFailToLocateUserWithError error: Error) {
            displayAlertWithTitle("Failed",
                message: "Could not get the user's location")
    }
    
    func mapView(_ mapView: MKMapView,
        didUpdate userLocation: MKUserLocation){
            
            print("Setting the camera for our map view...")
            
            let userCoordinate = userLocation.coordinate
            
            /* Assuming my location is hardcoded to
            lat: 58.592725 and long:16.185962, the following camera
            angle works perfectly for me */
            let eyeCoordinate = CLLocationCoordinate2D(
                latitude: 58.571647,
                longitude: 16.234660)
            
            let camera = MKMapCamera(
                lookingAtCenter: userCoordinate,
                fromEyeCoordinate: eyeCoordinate,
                eyeAltitude: 400.0)
            
            mapView.setCamera(camera, animated: true)
    }
    
    //- MARK: Helper methods
    /* Just a little method to help us display alert dialogs to the user */
    func displayAlertWithTitle(_ title: String, message: String){
        let controller = UIAlertController(title: title,
            message: message,
            preferredStyle: .alert)
        
        controller.addAction(UIAlertAction(title: "OK",
            style: .default,
            handler: nil))
        
        present(controller, animated: true, completion: nil)
        
    }
    
    /* We will call this method when we are sure that the user has given
    us access to her location */
    func showUserLocationOnMapView(){
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
    }
}

