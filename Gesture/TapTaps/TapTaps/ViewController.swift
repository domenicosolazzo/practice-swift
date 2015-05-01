//
//  ViewController.swift
//  TapTaps
//
//  Created by Domenico on 01/05/15.
//  Copyright (c) 2015 Domenico. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var singleLabel:UILabel!
    @IBOutlet var doubleLabel:UILabel!
    @IBOutlet var tripleLabel:UILabel!
    @IBOutlet var quadrupleLabel:UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let singleTap = UITapGestureRecognizer(target: self, action: "singleTap")
        singleTap.numberOfTapsRequired = 1
        singleTap.numberOfTouchesRequired = 1
        view.addGestureRecognizer(singleTap)
        
        let doubleTap = UITapGestureRecognizer(target: self, action: "doubleTap")
        doubleTap.numberOfTapsRequired = 2
        doubleTap.numberOfTouchesRequired = 1
        view.addGestureRecognizer(doubleTap)
        // Important line for avoiding singleTap twice
        singleTap.requireGestureRecognizerToFail(doubleTap)
        
        let tripleTap = UITapGestureRecognizer(target: self, action: "tripleTap")
        tripleTap.numberOfTapsRequired = 3
        tripleTap.numberOfTouchesRequired = 1
        view.addGestureRecognizer(tripleTap)
        doubleTap.requireGestureRecognizerToFail(tripleTap)
        
        let quadrupleTap = UITapGestureRecognizer(target: self, action: "quadrupleTap")
        quadrupleTap.numberOfTapsRequired = 4
        quadrupleTap.numberOfTouchesRequired = 1
        view.addGestureRecognizer(quadrupleTap)
        tripleTap.requireGestureRecognizerToFail(quadrupleTap)
    }

    func singleTap() {
        singleLabel.text = "Single Tap Detected"
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(2 * NSEC_PER_SEC)),
            dispatch_get_main_queue(),
            { self.singleLabel.text = "" })
    }
    
    func doubleTap() {
        doubleLabel.text = "Double Tap Detected"
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(2 * NSEC_PER_SEC)),
            dispatch_get_main_queue(),
            { self.doubleLabel.text = "" })
    }
    
    func tripleTap() {
        tripleLabel.text = "Triple Tap Detected"
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(2 * NSEC_PER_SEC)),
            dispatch_get_main_queue(),
            { self.tripleLabel.text = "" })
    }
    
    func quadrupleTap() {
        quadrupleLabel.text = "Quadruple Tap Detected"
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(2 * NSEC_PER_SEC)),
            dispatch_get_main_queue(),
            { self.quadrupleLabel.text = "" })
    }


}

