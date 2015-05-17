//
//  ViewController.swift
//  Detecting Which Floor the User Is on in a Building
//
//  Created by Domenico Solazzo on 17/05/15.
//  License MIT
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        println("Updated locations... \(__FUNCTION__)")
        
        if locations.count > 0{
            let location = (locations as! [CLLocation])[0]
            println("Location found = \(location)")
            if let theFloor = location.floor{
                println("The floor information is = \(theFloor)")
                println("Level: \(theFloor.level)")
            } else {
                println("No floor information is available")
            }
        }
    }
}

