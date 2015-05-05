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
}
