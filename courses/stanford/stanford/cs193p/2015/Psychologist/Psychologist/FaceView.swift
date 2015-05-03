//
//  FaceView.swift
//  Happiness
//
//  Created by Domenico on 19.03.15.
//  Copyright (c) 2015 Domenico Solazzo. All rights reserved.ha
//
import UIKit

protocol FaceViewDataSource: class{
    func smilinessForFaceView(sender: FaceView) -> Double?
}

@IBDesignable
class FaceView: UIView {
    @IBInspectable
    var lineWidth: CGFloat = 3 {didSet{ setNeedsDisplay()}}
    @IBInspectable
    var color:UIColor = UIColor.blueColor() {didSet{ setNeedsDisplay()}}
    @IBInspectable
    var scale: CGFloat = 0.90 {didSet{setNeedsDisplay()}}
    
    
    var faceCenter: CGPoint{
        // Convert center from the superview to FaceView
        return convertPoint(center, fromView: superview)
    }
    
    var faceRadius: CGFloat{
        return min(bounds.size.width, bounds.size.height) / 2 * scale
    }
    
    weak var dataSource: FaceViewDataSource?
    
    private struct Scaling{
        static let FaceRadiusToEyeRadiusRatio: CGFloat = 10
        static let FaceRadiusToEyeOffsetRatio: CGFloat = 3
        static let FaceRadiusToEyeSeparationRatio: CGFloat = 1.5
        static let FaceRadiusToMouthWidthRatio: CGFloat = 1
        static let FaceRadiusToMouthHeightRatio: CGFloat = 3
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
        
        // Smiliness
        var smiliness = dataSource?.smilinessForFaceView(self) ?? 0.0
        var smile = bezierPathForSmile(smiliness)
        smile.stroke()
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
    
    private func bezierPathForSmile(fractionOfMaxSmile: Double) -> UIBezierPath{
        let mouthWidth = faceRadius / Scaling.FaceRadiusToMouthWidthRatio
        let mouthHeight = faceRadius / Scaling.FaceRadiusToMouthHeightRatio
        let mouthVerticalOffset = faceRadius / Scaling.FaceRadiusToMouthOffsetRatio
        
        let smileHeight = CGFloat(max(min(fractionOfMaxSmile, 1), -1)) * mouthHeight
        
        let start = CGPoint(x: faceCenter.x - mouthWidth / 2, y: faceCenter.y + mouthVerticalOffset)
        let end = CGPoint(x: start.x + mouthWidth, y: start.y)
        let cp1 = CGPoint(x: start.x + mouthWidth / 3, y: start.y + smileHeight)
        let cp2 = CGPoint(x: end.x - mouthWidth / 3, y: cp1.y)
        
        let path = UIBezierPath()
        path.moveToPoint(start)
        path.addCurveToPoint(end, controlPoint1: cp1, controlPoint2: cp2)
        path.lineWidth = lineWidth
        return path
    }
    
    func scale(gesture:UIPinchGestureRecognizer){
        if(gesture.state == .Changed){
            scale *= gesture.scale
            gesture.scale = 1
        }
    }
}
