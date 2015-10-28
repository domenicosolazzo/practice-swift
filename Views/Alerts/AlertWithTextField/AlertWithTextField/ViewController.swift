//
//  ViewController.swift
//  AlertWithTextField
//
//  Created by Domenico Solazzo on 04/05/15.
//  License MIT
//

import UIKit

class ViewController: UIViewController {

    var controller:UIAlertController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        controller = UIAlertController(title: "Title",
            message: "Hello",
            preferredStyle: .Alert)
        
        // Adding a TextField
        controller!.addTextFieldWithConfigurationHandler(){(textField:UITextField!) in
            textField.placeholder = "XXXXXXX"
        }
        
        let action = UIAlertAction(title: "Done",
            style: UIAlertActionStyle.Default,
            handler: {[weak self](paramAction:UIAlertAction!) in
                if let textFields = self!.controller?.textFields{
                    var theTextFields = textFields 
                    let username = theTextFields[0].text
                    print("The username is \(username)")
                }
        })
        
        
        controller!.addAction(action)
        
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.presentViewController(controller!, animated: true, completion: nil)
    }

}

