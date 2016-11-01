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
    fileprivate var gestureStartPoint:CGPoint!
    fileprivate let minimumGestureLength = Float(25.0)
    fileprivate let maximumVariance = Float(5)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first! as UITouch
        gestureStartPoint = touch.location(in: self.view)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first! as UITouch
        let currentPosition = touch.location(in: self.view)
        
        let deltaX = fabsf(Float(gestureStartPoint.x - currentPosition.x))
        let deltaY = fabsf(Float(gestureStartPoint.y - currentPosition.y))
        
        if deltaX >= minimumGestureLength && deltaY <= maximumVariance {
            label.text = "Horizontal swipe detected"
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(2 * NSEC_PER_SEC)) / Double(NSEC_PER_SEC),
                execute: { self.label.text = "" })
        } else if deltaY >= minimumGestureLength && deltaX <= maximumVariance {
            label.text = "Vertical swipe detected"
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(2 * NSEC_PER_SEC)) / Double(NSEC_PER_SEC),
                execute: { self.label.text = "" })
        }
    }


}

