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
}

