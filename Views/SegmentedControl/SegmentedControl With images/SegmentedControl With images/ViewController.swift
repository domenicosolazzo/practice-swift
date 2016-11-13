//
//  ViewController.swift
//  SegmentedControl With images
//
//  Created by Domenico Solazzo on 05/05/15.
//  License MIT
//

import UIKit

class ViewController: UIViewController {
    var segmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let segments = NSArray(objects:
            "Red",
            UIImage(named: "blueDot")!,
            "Green",
            "Yellow"
        )
        
        segmentedControl = UISegmentedControl(items: segments as [AnyObject])
        segmentedControl.center = self.view.center
        // Add a target
        segmentedControl.addTarget(self, action: #selector(ViewController.segmentedControlValueChanged(_:)), for: UIControlEvents.valueChanged)
        
        self.view.addSubview(segmentedControl)
        
    }
    
    // Event
    func segmentedControlValueChanged(_ segmentedCtrl:UISegmentedControl){
        // Get the index
        let index = segmentedCtrl.selectedSegmentIndex
        
        // Get the title by index
        _ = segmentedCtrl.titleForSegment(at: index)
        if let title = segmentedControl.titleForSegment(at: index){
            print("Selected index \(index) with title \(title)")
        }
        
    }
}

