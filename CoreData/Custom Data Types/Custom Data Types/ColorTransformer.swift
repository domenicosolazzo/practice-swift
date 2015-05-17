//
//  ColorTransformer.swift
//  Custom Data Types
//
//  Created by Domenico Solazzo on 17/05/15.
//  License MIT
//

import UIKit

class ColorTransformer: NSValueTransformer {

    // It tells Core Data that you can turn colors into data and data back into colors.
    override class func allowsReverseTransformation() -> Bool{
        return true
    }
    
    // The return value of this class method tells Core Data what class you are 
    // transforming your custom value to.
    override class func transformedValueClass() -> AnyClass{
        return NSData.classForCoder()
    }
    
    // It takes the incoming value, transform it to NSData
    override func transformedValue(value: AnyObject!) -> AnyObject {
        
        /* Transform color to data */
        
        let color = value as! UIColor
        
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        var components = [red, green, blue, alpha]
        let dataFromColors = NSData(bytes: components,
            length: sizeofValue(components))
        
        return dataFromColors
        
    }
    
    // It takes the incoming value, which will be data, and transform it into your custom data type
    override func reverseTransformedValue(value: AnyObject!) -> AnyObject {
        
        /* Transform data to color */
        let data = value as! NSData
        var components = [CGFloat](count: 4, repeatedValue: 0.0)
        data.getBytes(&components, length: sizeofValue(components))
        
        let color = UIColor(red: components[0],
            green: components[1],
            blue: components[2],
            alpha: components[3])
        
        return color
        
    }
}
