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
    private var redrawRect:CGRect = CGRectZero
    
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
        
        if shape == .Image {
            let horizontalOffset = image.size.width / 2
            let verticalOffset = image.size.height / 2
            redrawRect = CGRectUnion(redrawRect,
                CGRectMake(lastTouchLocation.x - horizontalOffset,
                    lastTouchLocation.y - verticalOffset,
                    image.size.width, image.size.height))
        } else {
            redrawRect = CGRectUnion(redrawRect, currentRect())
        }
        setNeedsDisplayInRect(redrawRect)
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        let touch = touches.first as! UITouch
        lastTouchLocation = touch.locationInView(self)
        
        if shape == .Image {
            let horizontalOffset = image.size.width / 2
            let verticalOffset = image.size.height / 2
            redrawRect = CGRectUnion(redrawRect,
                CGRectMake(lastTouchLocation.x - horizontalOffset,
                    lastTouchLocation.y - verticalOffset,
                    image.size.width, image.size.height))
        } else {
            redrawRect = CGRectUnion(redrawRect, currentRect())
        }
        setNeedsDisplayInRect(redrawRect)
    }
    
    func currentRect() -> CGRect {
        return CGRectMake(firstTouchLocation.x,
            firstTouchLocation.y,
            lastTouchLocation.x - firstTouchLocation.x,
            lastTouchLocation.y - firstTouchLocation.y)
    }
    
    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(context, 2.0)
        CGContextSetStrokeColorWithColor(context, currentColor.CGColor)
        CGContextSetFillColorWithColor(context, currentColor.CGColor)
        
        switch shape {
        case .Line:
            CGContextMoveToPoint(context, firstTouchLocation.x,
                firstTouchLocation.y)
            CGContextAddLineToPoint(context, lastTouchLocation.x,
                lastTouchLocation.y)
            CGContextStrokePath(context)
            
        case .Rect:
            CGContextAddRect(context,  currentRect())
            CGContextDrawPath(context, kCGPathFillStroke)
            
        case .Ellipse:
            CGContextAddEllipseInRect(context, currentRect())
            CGContextDrawPath(context, kCGPathFillStroke)
            
        case .Image:
            let horizontalOffset = image.size.width / 2
            let verticalOffset = image.size.height / 2
            let drawPoint =
            CGPointMake(lastTouchLocation.x - horizontalOffset,
                lastTouchLocation.y - verticalOffset)
            image.drawAtPoint(drawPoint)
        }
    }
    
    
}
