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
        controller = UIAlertController(title: "Title", message: "Message", preferredStyle: UIAlertControllerStyle.alert)
        
        // Creating an action
        let action = UIAlertAction(title: "My action", style: UIAlertActionStyle.default){ (paramAction: UIAlertAction) in
                print("The button was tapped")
        }
        
        controller!.addAction(action)
    }

    override func viewDidAppear(_ animated: Bool) {
        self.present(controller!, animated: true, completion: nil)
    }


}

