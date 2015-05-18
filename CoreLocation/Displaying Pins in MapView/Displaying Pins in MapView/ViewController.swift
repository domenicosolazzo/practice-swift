//
//  ViewController.swift
//  Displaying Pins in MapView
//
//  Created by Domenico Solazzo on 18/05/15.
//  License MIT
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    var mapView: MKMapView!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        mapView = MKMapView()
    }

}

