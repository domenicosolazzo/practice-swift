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
    private let minimumCheckMarkAngle = CGFloat(50)
    private let maximumCheckMarkAngle = CGFloat(135)
    private let minimumCheckMarkLength = CGFloat(10)
    private var lastPreviousPoint = CGPointZero
    private var lastCurrentPoint = CGPointZero
    private var lineLengthSoFar = CGFloat(0)
}
