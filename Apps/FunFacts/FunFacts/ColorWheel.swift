//
//  ColorWheel.swift
//  FunFacts
//
//  Created by Domenico on 13/04/16.
//  Copyright © 2016 Domenico Solazzo. All rights reserved.
//

import Foundation
import UIKit

struct ColorWheel{
    let colorArray = [
        UIColor(colorLiteralRed: 59.0/255.0, green: 137.0/255.0, blue: 255.0, alpha: 1.0),
        UIColor(colorLiteralRed: 240.0/255.0, green: 100.0/255.0, blue: 10.0/255.0, alpha: 1.0),
        UIColor(colorLiteralRed: 10.0/255.0, green: 124.0/255.0, blue: 100.0/255.0, alpha: 1.0),
        UIColor(colorLiteralRed: 200.0/255.0, green: 150.0/255.0, blue: 50.0/255.0, alpha: 1.0),
        UIColor(colorLiteralRed: 100.0/255.0, green: 100.0/255.0, blue: 100.0/255, alpha: 1.0)
    ]
    
    func randomColor() -> UIColor{
        let unsignedArrayCount = UInt32(colorArray.count);
        let randomNumber = Int(arc4random_uniform(unsignedArrayCount))
        let randomColor = colorArray[randomNumber]
        return randomColor
    }
}
