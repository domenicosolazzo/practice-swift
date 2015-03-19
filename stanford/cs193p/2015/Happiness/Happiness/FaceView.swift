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
    var scale: CGFloat = 0.90 {didSet{setNeedsDisplay()}}
    
    
    var faceCenter: CGPoint{
        // Convert center from the superview to FaceView
        return convertPoint(center, fromView: superview)
    }
    
    var faceRadius: CGFloat{
        return min(bounds.size.width, bounds.size.height) / 2 * scale
    }
    
    private struct Scaling{
        static let FaceRadiusToEyeRadiusRatio: CGFloat = 10
        static let FaceRadiusToEyeOffsetRatio: CGFloat = 3
        static let FaceRadiusToEyeSeparationRatio: CGFloat = 1.5
        static let FaceRadiusToMouthWidthRatio: CGFloat = 1
        static let FaceRadiusToEMouthHeightRatio: CGFloat = 3
        static let FaceRadiusToMouthOffsetRatio: CGFloat = 3
    }
    
    override func drawRect(rect: CGRect) {
        let facePath = UIBezierPath(arcCenter: faceCenter, radius: faceRadius, startAngle: CGFloat(0), endAngle: CGFloat(2*M_PI), clockwise: true)
        facePath.lineWidth = lineWidth
        // Set the color
        color.set()
        // Draw
        facePath.stroke()
        
        // Draw the eyes
        bezierPathForEye(.Left).stroke()
        bezierPathForEye(.Right).stroke()
    }
    private enum Eye{case Left, Right}
    
    private func bezierPathForEye(whichEye: Eye) -> UIBezierPath{
        var eyeRadius = faceRadius / Scaling.FaceRadiusToEyeRadiusRatio
        var eyeVerticalOffset = faceRadius / Scaling.FaceRadiusToEyeOffsetRatio
        var eyeHorizontalSeparation = faceRadius / Scaling.FaceRadiusToEyeSeparationRatio
        var eyeCenter = faceCenter
        eyeCenter.y -= eyeVerticalOffset
        switch whichEye{
        case .Left: eyeCenter.x -= eyeHorizontalSeparation / 2
        case .Right: eyeCenter.x += eyeHorizontalSeparation / 2
        }
        var path = UIBezierPath(arcCenter: eyeCenter, radius: eyeRadius, startAngle: 0, endAngle: CGFloat(2*M_PI), clockwise: true)
        path.lineWidth = lineWidth
        return path
    }
}
