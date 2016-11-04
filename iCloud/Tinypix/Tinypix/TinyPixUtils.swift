//
//  TinyPixUtils.swift
//  Tinypix
//
//  Created by Domenico on 28/04/15.
//  Copyright (c) 2015 Domenico Solazzo. All rights reserved.
//

import UIKit

class TinyPixUtils {
    class func getTintColorForIndex(_ index: Int) -> UIColor {
        var color: UIColor
        switch index {
        case 0:
            color = UIColor.red
            
        case 1:
            color = UIColor(red: 0, green: 0.6, blue: 0, alpha: 1)
            
        case 2:
            color = UIColor.blue
            
        default:
            color = UIColor.red
        }
        return color
    }
}
