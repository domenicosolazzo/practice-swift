//
//  BallView.swift
//  Ball
//
//  Created by Domenico on 02/05/15.
//  Copyright (c) 2015 Domenico. All rights reserved.
//

import UIKit
import CoreMotion

class BallView: UIView {
    var acceleration = CMAcceleration(x: 0, y: 0, z: 0)
    fileprivate let image = UIImage(named : "ball")!
    var currentPoint : CGPoint = CGPoint.zero {
        didSet {
            var newX = currentPoint.x
            var newY = currentPoint.y
            if newX < 0 {
                newX = 0
                ballXVelocity = -(ballXVelocity / 2.0)
            } else if newX > bounds.size.width - image.size.width {
                newX = bounds.size.width - image.size.width
                ballXVelocity = -(ballXVelocity / 2.0)
            }
            if newY < 0 {
                newY = 0
                ballYVelocity = -(ballYVelocity / 2.0)
            } else if newY > bounds.size.height - image.size.height {
                newY = bounds.size.height - image.size.height
                ballYVelocity = -(ballYVelocity / 2.0)
            }
            currentPoint = CGPoint(x: newX, y: newY)
            
            let currentRect = CGRect(x: newX, y: newY,
                width: newX + image.size.width,
                height: newY + image.size.height)
            let prevRect = CGRect(x: oldValue.x, y: oldValue.y,
                width: oldValue.x + image.size.width,
                height: oldValue.y + image.size.height)
            setNeedsDisplay(currentRect.union(prevRect))
        }
    }
    
    fileprivate var ballXVelocity = 0.0
    fileprivate var ballYVelocity = 0.0
    fileprivate var lastUpdateTime = Date()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() -> Void {
        currentPoint = CGPoint(x: (bounds.size.width / 2.0) +
            (image.size.width / 2.0),
            y: (bounds.size.height / 2.0) +
                (image.size.height / 2.0))
    }
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        image.draw(at: currentPoint)
    }
    
    func update() -> Void {
        let now = Date()
        let secondsSinceLastDraw = now.timeIntervalSince(lastUpdateTime)
        ballXVelocity =
            ballXVelocity + (acceleration.x * secondsSinceLastDraw)
        ballYVelocity =
            ballYVelocity - (acceleration.y * secondsSinceLastDraw)
        
        let xDelta = secondsSinceLastDraw * ballXVelocity * 500
        let yDelta = secondsSinceLastDraw * ballYVelocity * 500
        currentPoint = CGPoint(x: currentPoint.x + CGFloat(xDelta),
            y: currentPoint.y + CGFloat(yDelta))
        lastUpdateTime = now
    }
    
    
}
