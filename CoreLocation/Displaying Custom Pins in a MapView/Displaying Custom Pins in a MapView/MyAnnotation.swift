//
//  MyAnnotation.swift
//  Displaying Custom Pins in a MapView
//
//  Created by Domenico Solazzo on 19/05/15.
//  License MIT
//

import UIKit
import MapKit

/* This will allow us to check for equality between two items
of type PinColor */
func == (left: PinColor, right: PinColor) -> Bool{
    return left.rawValue == right.rawValue
}

/* The various pin colors that our annotation can have */
enum PinColor : String{
    case Blue = "Blue"
    case Red = "Red"
    case Green = "Green"
    case Purple = "Purple"
    
    /* We will convert our pin color to the system pin color */
    func toPinColor() -> MKPinAnnotationColor{
        switch self{
        case .Red:
            return .Red
        case .Green:
            return .Green
        case .Purple:
            return .Purple
        default:
            /* For the blue pin, this will return .Red but we need
            to return *a* value in this function. For this case, we will
            ignore the return value */
            return .Red
        }
    }
}

class MyAnnotation: NSObject, MKAnnotation {
    let coordinate: CLLocationCoordinate2D
    var title: String!
    var subtitle: String!
    var pinColor: PinColor!
    
    init(coordinate: CLLocationCoordinate2D,
        title: String,
        subtitle: String,
        pinColor: PinColor){
            self.coordinate = coordinate
            self.title = title
            self.subtitle = subtitle
            self.pinColor = pinColor
            super.init()
    }
    
    convenience init(coordinate: CLLocationCoordinate2D,
        title: String,
        subtitle: String){
            self.init(coordinate: coordinate,
                title: title,
                subtitle: subtitle,
                pinColor: .Blue)
    }
    
}