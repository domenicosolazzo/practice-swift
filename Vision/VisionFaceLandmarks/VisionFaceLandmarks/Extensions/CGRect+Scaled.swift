//
//  CGRect+Scaled.swift
//  VisionFaceLandmarks
//
//  Created by Domenico Solazzo on 8/25/17.
//  Copyright © 2017 Domenico Solazzo. All rights reserved.
//

import Foundation
import UIKit

extension CGRect {
    func scaled(to size: CGSize) -> CGRect {
        return CGRect(
            x: self.origin.x * size.width,
            y: self.origin.y * size.height,
            width: self.size.width * size.width,
            height: self.size.height * size.height
        )
    }
}
