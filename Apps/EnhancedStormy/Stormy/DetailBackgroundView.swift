//
//  DetailBackgroundView.swift
//  Stormy
//
//  Created by Pasan Premaratne on 6/18/15.
//  Copyright (c) 2015 Treehouse. All rights reserved.
//

import UIKit

class DetailBackgroundView: UIView {

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        //// Color Declarations
        let lightPurple: UIColor = UIColor(red: 0.377, green: 0.075, blue: 0.778, alpha: 1.000)
        let darkPurple: UIColor = UIColor(red: 0.060, green: 0.036, blue: 0.202, alpha: 1.000)
        
        let context = UIGraphicsGetCurrentContext()
        
        //// Gradient Declarations
        let purpleGradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: [lightPurple.cgColor, darkPurple.cgColor], locations: [0, 1])
        
        //// Background Drawing
        let backgroundPath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        context?.saveGState()
        backgroundPath.addClip()
        context.drawLinearGradient(purpleGradient,
            start: CGPoint(x: 160, y: 0),
            end: CGPoint(x: 160, y: 568),
            options: [.drawsBeforeStartLocation, .drawsAfterEndLocation])
        context?.restoreGState()
        
        //// Sun Path
        
        let circleOrigin = CGPoint(x: 0, y: 0.80 * self.frame.height)
        let circleSize = CGSize(width: self.frame.width, height: 0.65 * self.frame.height)
        
        let pathStrokeColor = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.390)
        let pathFillColor = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.100)
        
        
        //// Sun Drawing
        let sunPath = UIBezierPath(ovalIn: CGRect(x: circleOrigin.x, y: circleOrigin.y, width: circleSize.width, height: circleSize.height))
        pathFillColor.setFill()
        sunPath.fill()
        pathStrokeColor.setStroke()
        sunPath.lineWidth = 1
        context?.saveGState()
        CGContextSetLineDash(context, 0, [2, 2], 2)
        sunPath.stroke()
        context?.restoreGState()

    }

}
