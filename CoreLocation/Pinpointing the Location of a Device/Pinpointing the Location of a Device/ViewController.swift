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
    
    
}

