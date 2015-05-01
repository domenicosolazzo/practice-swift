//
//  ViewController.swift
//  GestureRecognizer
//
//  Created by Domenico on 01/05/15.
//  Copyright (c) 2015 Domenico. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var label:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let vertical = UISwipeGestureRecognizer(target: self, action: "reportVerticalSwipe:")
        vertical.direction = .Up | .Down
        view.addGestureRecognizer(vertical)
        
        let horizontal = UISwipeGestureRecognizer(target: self, action: "reportHorizontalSwipe:")
        horizontal.direction = .Left | .Right
        view.addGestureRecognizer(horizontal)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func reportHorizontalSwipe(recognizer:UIGestureRecognizer) {
        label.text = "Horizontal swipe detected"
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(2 * NSEC_PER_SEC)),
            dispatch_get_main_queue(),
            { self.label.text = "" })
    }
    
    func reportVerticalSwipe(recognizer:UIGestureRecognizer) {
        label.text = "Vertical swipe detected"
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(2 * NSEC_PER_SEC)),
            dispatch_get_main_queue(),
            { self.label.text = "" })
    }
    
}

