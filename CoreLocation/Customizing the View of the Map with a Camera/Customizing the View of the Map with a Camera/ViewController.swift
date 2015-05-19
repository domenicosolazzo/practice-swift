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
}

