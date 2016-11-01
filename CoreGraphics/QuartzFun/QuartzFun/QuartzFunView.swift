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
    case line = 0, rect, ellipse, image
}

// The color tab indices
enum DrawingColor : UInt {
    case red = 0, blue, yellow, green, random
}

class QuartzFunView: UIView {
    // Application-settable properties
    var shape = Shape.line
    var currentColor = UIColor.red
    var useRandomColor = false
    fileprivate var redrawRect:CGRect = CGRect.zero
    
    // Internal properties
    fileprivate let image = UIImage(named:"iphone")!
    fileprivate var firstTouchLocation:CGPoint = CGPoint.zero
    fileprivate var lastTouchLocation:CGPoint = CGPoint.zero
    
    //- MARK: Touches
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if useRandomColor {
            currentColor = UIColor.randomColor()
        }
        
        let touch = touches.first! as UITouch
        firstTouchLocation = touch.location(in: self)
        lastTouchLocation = firstTouchLocation
        setNeedsDisplay()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first! as UITouch
        lastTouchLocation = touch.location(in: self)
        
        if shape == .image {
            let horizontalOffset = image.size.width / 2
            let verticalOffset = image.size.height / 2
            redrawRect = redrawRect.union(CGRect(x: lastTouchLocation.x - horizontalOffset,
                    y: lastTouchLocation.y - verticalOffset,
                    width: image.size.width, height: image.size.height))
        } else {
            redrawRect = redrawRect.union(currentRect())
        }
        setNeedsDisplay(redrawRect)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first! as UITouch
        lastTouchLocation = touch.location(in: self)
        
        if shape == .image {
            let horizontalOffset = image.size.width / 2
            let verticalOffset = image.size.height / 2
            redrawRect = redrawRect.union(CGRect(x: lastTouchLocation.x - horizontalOffset,
                    y: lastTouchLocation.y - verticalOffset,
                    width: image.size.width, height: image.size.height))
        } else {
            redrawRect = redrawRect.union(currentRect())
        }
        setNeedsDisplay(redrawRect)
    }
    
    func currentRect() -> CGRect {
        return CGRect(x: firstTouchLocation.x,
            y: firstTouchLocation.y,
            width: lastTouchLocation.x - firstTouchLocation.x,
            height: lastTouchLocation.y - firstTouchLocation.y)
    }
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context?.setLineWidth(2.0)
        context?.setStrokeColor(currentColor.cgColor)
        context?.setFillColor(currentColor.cgColor)
        
        switch shape {
        case .line:
            context?.move(to: CGPoint(x: firstTouchLocation.x, y: firstTouchLocation.y))
            context?.addLine(to: CGPoint(x: lastTouchLocation.x, y: lastTouchLocation.y))
            context?.strokePath()
            
        case .rect:
            context?.addRect(currentRect())
            context?.drawPath(using: CGPathDrawingMode.fillStroke)
            
        case .ellipse:
            context?.addEllipse(in: currentRect())
            context?.drawPath(using: CGPathDrawingMode.fillStroke)
            
        case .image:
            let horizontalOffset = image.size.width / 2
            let verticalOffset = image.size.height / 2
            let drawPoint =
            CGPoint(x: lastTouchLocation.x - horizontalOffset,
                y: lastTouchLocation.y - verticalOffset)
            image.draw(at: drawPoint)
        }
    }
    
    
}
