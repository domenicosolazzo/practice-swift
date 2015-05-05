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
        // Add a target
        segmentedControl.addTarget(self, action: "segmentedControlValueChanged:", forControlEvents: UIControlEvents.ValueChanged)
        
        self.view.addSubview(segmentedControl)
        
    }
    
    // Event
    func segmentedControlValueChanged(segmentedCtrl:UISegmentedControl){
        // Get the index
        var index = segmentedCtrl.selectedSegmentIndex
        
        // Get the title by index
        var title = segmentedCtrl.titleForSegmentAtIndex(index)
        
        println("Selected index \(index) with title \(title!)")
    }
}

