//
//  QuartzFunView.swift
//  QuartzFun
//
//  Created by Domenico on 01/05/15.
//  Copyright (c) 2015 Domenico. All rights reserved.
//

import UIKit

// Random color extension of UIColor
extension UIColor {
    class func randomColor() -> UIColor {
        let red = CGFloat(Double((arc4random() % 256))/255)
        let green = CGFloat(Double(arc4random() % 256)/255)
        let blue = CGFloat(Double(arc4random() % 256)/255)
        return UIColor(red: red, green: green, blue: blue, alpha:1.0)
    }
}


enum Shape : UInt {
    case Line = 0, Rect, Ellipse, Image
}

// The color tab indices
enum DrawingColor : UInt {
    case Red = 0, Blue, Yellow, Green, Random
}

class QuartzFunView: UIView {
    // Application-settable properties
    var shape = Shape.Line
    var currentColor = UIColor.redColor()
    var useRandomColor = false
    
    // Internal properties
    private let image = UIImage(named:"iphone")!
    private var firstTouchLocation:CGPoint = CGPointZero
    private var lastTouchLocation:CGPoint = CGPointZero
    
    //- MARK: Touches
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        if useRandomColor {
            currentColor = UIColor.randomColor()
        }
        
        let touch = touches.first as! UITouch
        firstTouchLocation = touch.locationInView(self)
        lastTouchLocation = firstTouchLocation
        setNeedsDisplay()
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        let touch = touches.first as! UITouch
        lastTouchLocation = touch.locationInView(self)
        setNeedsDisplay()
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        let touch = touches.first as! UITouch
        lastTouchLocation = touch.locationInView(self)
        setNeedsDisplay()
    }
}
