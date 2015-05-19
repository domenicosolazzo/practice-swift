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
    
    
    //- MARK: Helper methods
    func displayAlertWithTitle(title: String, message: String){
        let controller = UIAlertController(title: title,
            message: message,
            preferredStyle: .Alert)
        
        controller.addAction(UIAlertAction(title: "OK",
            style: .Default,
            handler: nil))
        
        presentViewController(controller, animated: true, completion: nil)
        
    }
    
    //- MARK: LocationManager
    func locationManager(manager: CLLocationManager!,
        didChangeAuthorizationStatus status: CLAuthorizationStatus){
            
            print("The authorization status of location " +
                "services is changed to: ")
            
            switch CLLocationManager.authorizationStatus(){
            case .Denied:
                println("Denied")
            case .NotDetermined:
                println("Not determined")
            case .Restricted:
                println("Restricted")
            default:
                println("Authorized")
                provideDirections()
            }
            
    }
    
    func provideDirections(){
        let destination = "Godsgatan, Norrköping, Sweden"
        CLGeocoder().geocodeAddressString(destination,
            completionHandler: {(placemarks: [AnyObject]!, error: NSError!) in
                
                if error != nil{
                    /* Handle the error here perhaps by displaying an alert */
                } else {
                    let request = MKDirectionsRequest()
                    request.setSource(MKMapItem.mapItemForCurrentLocation())
                    
                    /* Convert the CoreLocation destination
                    placemark to a MapKit placemark */
                    let placemark = placemarks[0] as! CLPlacemark
                    let destinationCoordinates =
                    placemark.location.coordinate
                    /* Get the placemark of the destination address */
                    let destination = MKPlacemark(coordinate:
                        destinationCoordinates,
                        addressDictionary: nil)
                    
                    request.setDestination(MKMapItem(placemark: destination))
                    
                    /* Set the transportation method to automobile */
                    request.transportType = .Automobile
                    
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
                    }
                    
                }
                
        })
    }
    
    
}

