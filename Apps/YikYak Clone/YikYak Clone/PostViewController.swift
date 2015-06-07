//
//  PostViewController.swift
//  YikYak Clone
//
//  Created by Domenico on 07/06/15.
//  Copyright (c) 2015 Domenico. All rights reserved.
//

import UIKit
import CoreLocation

class PostViewController: UIViewController, UITextViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var postView: UITextView!
    var currLocation: CLLocationCoordinate2D?
    var reset:Bool = false
    let locationManager = CLLocationManager()
    
    @IBAction func postPressed(sender: UIBarButtonItem) {
    }
    @IBAction func cancelPressed(sender: UIBarButtonItem) {
    }
}
