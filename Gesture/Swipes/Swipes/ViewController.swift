//
//  ViewController.swift
//  Swipes
//
//  Created by Domenico on 01/05/15.
//  Copyright (c) 2015 Domenico. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var label:UILabel!
    // First touch position
    private var gestureStartPoint:CGPoint!
    private let minimumGestureLength = Float(25.0)
    private let maximumVariance = Float(5)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        let touch = touches.first as! UITouch
        gestureStartPoint = touch.locationInView(self.view)
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        let touch = touches.first as! UITouch
        let currentPosition = touch.locationInView(self.view)
        
        let deltaX = fabsf(Float(gestureStartPoint.x - currentPosition.x))
        let deltaY = fabsf(Float(gestureStartPoint.y - currentPosition.y))
        
        if deltaX >= minimumGestureLength && deltaY <= maximumVariance {
            label.text = "Horizontal swipe detected"
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(2 * NSEC_PER_SEC)),
                dispatch_get_main_queue(),
                { self.label.text = "" })
        } else if deltaY >= minimumGestureLength && deltaX <= maximumVariance {
            label.text = "Vertical swipe detected"
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(2 * NSEC_PER_SEC)),
                dispatch_get_main_queue(),
                { self.label.text = "" })
        }
    }


}

