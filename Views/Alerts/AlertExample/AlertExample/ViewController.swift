//
//  ViewController.swift
//  AlertExample
//
//  Created by Domenico on 04/05/15.
//  License MIT
//

import UIKit

class ViewController: UIViewController {

    // Alert controller
    var controller: UIAlertController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Initializing the AlertController
        controller = UIAlertController(title: "Title", message: "Message", preferredStyle: UIAlertControllerStyle.Alert)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

