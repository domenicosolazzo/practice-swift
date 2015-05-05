//
//  ViewController.swift
//  SegmentedControlExample
//
//  Created by Domenico Solazzo on 05/05/15.
//  License MIT
//

import UIKit

class ViewController: UIViewController {

    var segmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let segments = [
            "iPhone",
            "iPad",
            "iPod",
            "iMac"
        ]
        
        segmentedControl = UISegmentedControl(items: segments)
        segmentedControl.center = self.view.center
        self.view.addSubview(segmentedControl)
    }
}

