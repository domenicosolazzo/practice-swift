//
//  ViewController.swift
//  SimplePicker
//
//  Created by Domenico Solazzo on 04/05/15.
//  License MIT
//

import UIKit

class ViewController: UIViewController {

    // PickerView
    var uiPicker: UIPickerView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        uiPicker = UIPickerView()
        // Setting the picker in the center of the screen
        uiPicker?.center = view.center
        // Adding a subview
        self.view.addSubview(uiPicker!)
    }
}

