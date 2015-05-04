//
//  ViewController.swift
//  UISwitchExample
//
//  Created by Domenico Solazzo on 04/05/15.
//  License MIT
//

import UIKit

class ViewController: UIViewController {

    // UISwitch
    var uiSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Creating a switch
        uiSwitch = UISwitch(frame: CGRect(x: 100, y: 100, width: 0, height: 0))
        // Adding the subview
        self.view.addSubview(uiSwitch)
        
        
    }


}

