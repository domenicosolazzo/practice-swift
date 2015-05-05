//
//  StringReverserActivity.swift
//  Custom Activity
//
//  Created by Domenico Solazzo on 05/05/15.
//  License MIT
//

import UIKit

class StringReverserActivity: UIActivity {
    // Items that will be sent to this activity
    var activityItems = [NSString]()
    
    // Activity type
    override func activityType() -> String? {
        return NSBundle.mainBundle().bundleIdentifier! + ".StringReverseActivity"
    }
    
    // This string will be shown to the user
    override func activityTitle() -> String? {
        return "Reverse String"
    }
    
    // Image for the UIActivity
    override func activityImage() -> UIImage? {
        return UIImage(named: "Reverse")
    }
    
    // Check if can perform this activity
    override func canPerformWithActivityItems(activityItems: [AnyObject]) -> Bool {
        for object in activityItems{
            if object is String{
                // At least an object is a string and can use this activity
                return true
            }
        }
        
        // No object was valid for this activity
        return false
    }
    
    // Saving the items that we need to use. This method is called
    // if canPerformWithActivityItems returns true
    override func prepareWithActivityItems(paramActivityItems: [AnyObject]) {
        for object in paramActivityItems{
            if object is String{
                activityItems.append(object as! String)
            }
        }
    }
    
    
}
