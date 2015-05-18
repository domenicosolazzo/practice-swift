
//
//  MyAnnotation.swift
//  Displaying Pins in MapView
//
//  Created by Domenico Solazzo on 18/05/15.
//  License MIT
//

import UIKit
import MapKit

class MyAnnotation: NSObject, MKAnnotation {
    let coordinate: CLLocationCoordinate2D
    let title:String!
    let subtitle:String!
    
    init(coordinate: CLLocationCoordinate2D, title:String, subtitle:String){
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        super.init()
    }
}
