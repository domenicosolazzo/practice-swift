//
//  ViewController.swift
//  Pinpointing the Location of a Device
//
//  Created by Domenico Solazzo on 18/05/15.
//  License MIT
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    // Private variables
    var locationManager: CLLocationManager?
    
    // It is called when the authorization status of your location manager is changed by the user
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        print("The authorization status of location services is changed to: ")
        
        switch CLLocationManager.authorizationStatus(){
        case .AuthorizedAlways:
            println("Authorized always")
        case .AuthorizedWhenInUse:
            println("Authorized when in use")
        case .Denied:
            println("Denied")
        case .NotDetermined:
            println("Not determined")
        case .Restricted:
            println("Restricted")
        default:
            println("Unhandled")
        }
    }
    
    // It is called when there is an error fetching the user's location
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println("Failure retrieving the user's location. Error: \(error)")
    }
    
    // System got a location update
    func locationManager(manager: CLLocationManager!, didUpdateToLocation newLocation: CLLocation!, fromLocation oldLocation: CLLocation!) {
        println("Location - Latitude: \(newLocation.coordinate.latitude)")
        println("Location - Longitude: \(newLocation.coordinate.longitude)")
    }
    
    //- MARK: Helper methods
    func displayAlertWithTitle(title:String, message:String){
        var alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        presentViewController(alertController, animated: true, completion: nil)
    }
}

