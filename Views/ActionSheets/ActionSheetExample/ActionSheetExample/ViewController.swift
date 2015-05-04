//
//  ViewController.swift
//  ActionSheetExample
//
//  Created by Domenico Solazzo on 04/05/15.
//  License MIT
//

import UIKit

class ViewController: UIViewController {

    // Controller
    var controller: UIAlertController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Creating a new action sheet
        controller = UIAlertController(title: "My action sheet", message: "How do you want to send a message", preferredStyle: UIAlertControllerStyle.ActionSheet)
    }

    


}

