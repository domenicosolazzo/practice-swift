//
//  Geometry.swift
//  TextShooter
//
//  Created by Domenico on 01/05/15.
//  Copyright (c) 2015 Domenico. All rights reserved.
//
import Foundation
import UIKit

// Takes a CGVector and a CGFLoat.
// Returns a new CGFloat where each component of v has been multiplied by m.

func vectorMultiply(_ v: CGVector, m: CGFloat) -> CGVector {
    return CGVector(dx: v.dx * m, dy: v.dy * m)
}

// Takes two CGPoints.
// Returns a CGVector representing a direction from p1 to p2.
func vectorBetweenPoints(_ p1: CGPoint, p2: CGPoint) -> CGVector {
    return CGVector(dx: p2.x - p1.x, dy: p2.y - p1.y)
}

// Takes a CGVector.
// Returns a CGFloat containing the length of the vector, calculated using
// Pythagoras' theorem.
func vectorLength(_ v: CGVector) -> CGFloat {
    return CGFloat(sqrtf(powf(Float(v.dx), 2) + powf(Float(v.dy), 2)))
}

// Takes two CGPoints. Returns a CGFloat containing the distance between them,
// calculated with Pythagoras' theorem.
func pointDistance(_ p1: CGPoint, p2: CGPoint) -> CGFloat {
    return CGFloat(
        sqrtf(powf(Float(p2.x - p1.x), 2) + powf(Float(p2.y - p1.y), 2)))
}
