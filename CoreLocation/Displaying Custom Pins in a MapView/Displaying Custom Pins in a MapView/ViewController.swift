//
//  ViewController.swift
//  Displaying Custom Pins in a MapView
//
//  Created by Domenico Solazzo on 19/05/15.
//  License MIT
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

    var mapView: MKMapView!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        mapView = MKMapView()
    }
    
    /* We have a pin on the map, now zoom into it and make that pin
    the center of the map */
    func setCenterOfMapToLocation(location: CLLocationCoordinate2D){
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
    }

}

