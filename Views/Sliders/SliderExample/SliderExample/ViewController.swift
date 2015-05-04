//
//  ViewController.swift
//  SliderExample
//
//  Created by Domenico Solazzo on 05/05/15.
//  LICENSE MIT
//

import UIKit

class ViewController: UIViewController {

    // Slider
    var slider:UISlider?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        slider = UISlider(frame: CGRect(x: 0, y: 0, width: 200, height: 23))
        slider!.center = self.view.center
        // Max value
        slider?.maximumValue = 100
        // Min value
        slider?.minimumValue = 0
        
        // Current Value
        slider?.value = slider!.maximumValue / 2.0
    }

}

