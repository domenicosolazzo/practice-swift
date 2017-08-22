//
//  ClosedGroup.swift
//  ARShaperAdder
//
//  Created by Domenico Solazzo on 8/22/17.
//  Copyright © 2017 Domenico Solazzo. All rights reserved.
//

import Foundation

extension ClosedRange where Bound : FloatingPoint {
    public func random() -> Bound {
        let range = self.upperBound - self.lowerBound
        let randomValue = (Bound(arc4random_uniform(UINT32_MAX)) / Bound(UINT32_MAX)) * range + self.lowerBound
        return randomValue
    }
}
