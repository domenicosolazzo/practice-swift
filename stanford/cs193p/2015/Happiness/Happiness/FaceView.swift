//
//  FaceView.swift
//  Happiness
//
//  Created by Domenico on 19.03.15.
//  Copyright (c) 2015 Domenico Solazzo. All rights reserved.ha
//
import UIKit

class FaceView: UIView {
    var lineWidth: CGFloat = 3 {didSet{ setNeedsDisplay()}}
    var color:UIColor = UIColor.blueColor() {didSet{ setNeedsDisplay()}}
    var faceCenter: CGPoint{
        // Convert center from the superview to FaceView
        return convertPoint(center, fromView: superview)
    }
    
    var faceRadius: CGFloat{
        return min(bounds.size.width, bounds.size.height) / 2
    }
    
    override func drawRect(rect: CGRect) {
        let facePath = UIBezierPath(arcCenter: faceCenter, radius: faceRadius, startAngle: CGFloat(0), endAngle: CGFloat(2*M_PI), clockwise: true)
        facePath.lineWidth = lineWidth
        // Set the color
        color.set()
        // Draw
        facePath.stroke()
    }
}
