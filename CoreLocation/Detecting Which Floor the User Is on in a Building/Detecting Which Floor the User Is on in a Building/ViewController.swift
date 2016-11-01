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

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Updated locations... \(#function)")
        
        if locations.count > 0{
            let location = (locations )[0]
            print("Location found = \(location)")
            if let theFloor = location.floor{
                print("The floor information is = \(theFloor)")
                print("Level: \(theFloor.level)")
            } else {
                print("No floor information is available")
            }
        }
    }
}

