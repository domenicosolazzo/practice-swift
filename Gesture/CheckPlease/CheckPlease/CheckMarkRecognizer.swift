//
//  CheckMarkRecognizer.swift
//  CheckPlease
//
//  Created by Domenico on 02/05/15.
//  Copyright (c) 2015 Domenico. All rights reserved.
//

import UIKit
import UIKit.UIGestureRecognizerSubclass

class CheckMarkRecognizer: UIGestureRecognizer {
    fileprivate let minimumCheckMarkAngle = CGFloat(50)
    fileprivate let maximumCheckMarkAngle = CGFloat(135)
    fileprivate let minimumCheckMarkLength = CGFloat(10)
    fileprivate var lastPreviousPoint = CGPoint.zero
    fileprivate var lastCurrentPoint = CGPoint.zero
    fileprivate var lineLengthSoFar = CGFloat(0)
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesBegan(touches , with: event)
        let touch = touches.first! as UITouch
        let point = touch.location(in: view)
        lastPreviousPoint = point
        lastCurrentPoint = point
        lineLengthSoFar = 0;
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesMoved(touches , with: event)
        let touch = touches.first! as UITouch
        let previousPoint = touch.previousLocation(in: view)
        let currentPoint = touch.location(in: view)
        let angle = angleBetweenLines(lastPreviousPoint, line1End: lastCurrentPoint,
                                      line2Start: previousPoint,  line2End: currentPoint)
        if angle >= minimumCheckMarkAngle && angle <= maximumCheckMarkAngle && lineLengthSoFar > minimumCheckMarkLength {
            self.state = .ended
        }
        lineLengthSoFar += distanceBetweenPoints(previousPoint, second: currentPoint)
        lastPreviousPoint = previousPoint
        lastCurrentPoint = currentPoint
    }
}
