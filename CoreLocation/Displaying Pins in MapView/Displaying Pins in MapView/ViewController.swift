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
    
    /* We have a pin on the map; now zoom into it and make that pin
    the center of the map */
    func setCenterOfMapToLocation(location: CLLocationCoordinate2D){
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    func addPinToMapView(){
        
        /* This is just a sample location */
        let location = CLLocationCoordinate2D(latitude: 58.592737,
            longitude: 16.185898)
        
        /* Create the annotation using the location */
        let annotation = MyAnnotation(coordinate: location,
            title: "My Title",
            subtitle: "My Sub Title")
        
        /* And eventually add it to the map */
        mapView.addAnnotation(annotation)
        
        /* And now center the map around the point */
        setCenterOfMapToLocation(location)
        
    }

}

