//
//  CGPointUtils.swift
//  CheckPlease
//
//  Created by Domenico on 02/05/15.
//  Copyright (c) 2015 Domenico. All rights reserved.
//

import UIKit

func degreesToRadians(degrees:CGFloat) -> CGFloat {
    return CGFloat(M_PI * Double(degrees)/180)
}

func radiansToDegrees(radians:CGFloat) -> CGFloat {
    return CGFloat(180 * Double(radians)/M_PI)
}

func distanceBetweenPoints(first:CGPoint, second:CGPoint) -> CGFloat {
    let deltaX = second.x - first.x
    let deltaY = second.y - first.y
    return sqrt(deltaX * deltaX + deltaY * deltaY)
}

func angleBetweenPoint(first:CGPoint, second:CGPoint) -> CGFloat {
    let height = fabs(second.y - first.y)
    let width = fabs(second.x - first.x)
    let radians = atan(height/width)
    return radiansToDegrees(radians)
}

func angleBetweenLines(line1Start:CGPoint, line1End:CGPoint, line2Start:CGPoint, line2End:CGPoint) -> CGFloat {
    let a = line1End.x - line1Start.x;
    let b = line1End.y - line1Start.y;
    let c = line2End.x - line2Start.x;
    let d = line2End.y - line2Start.y;
    let radians = acos(((a*c) + (b*d)) / ((sqrt(a*a + b*b)) * (sqrt(c*c + d*d))));
    
    return radiansToDegrees(radians);
}
