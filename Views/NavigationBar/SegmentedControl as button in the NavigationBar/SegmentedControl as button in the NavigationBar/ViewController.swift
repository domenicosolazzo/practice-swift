//
//  ViewController.swift
//  SegmentedControl as button in the NavigationBar
//
//  Created by Domenico Solazzo on 06/05/15.
//  License MIT
//

import UIKit

class ViewController: UIViewController {

    let items = ["Up", "Down"]
    
    func segmentedControlValueChanged(_ sender: UISegmentedControl){
        if (sender.selectedSegmentIndex < items.count){
            print(items[sender.selectedSegmentIndex])
        }else{
            print("Unknown button")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.isMomentary = true
        
        segmentedControl.addTarget(self, action: #selector(ViewController.segmentedControlValueChanged(_:)), for: UIControlEvents.valueChanged)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: segmentedControl)
    }
}

