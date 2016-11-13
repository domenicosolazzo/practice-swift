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
    override var activityType : String? {
        return Bundle.main.bundleIdentifier! + ".StringReverseActivity"
    }
    
    // This string will be shown to the user
    override var activityTitle : String? {
        return "Reverse String"
    }
    
    // Image for the UIActivity
    override var activityImage : UIImage? {
        return UIImage(named: "Reverse")
    }
    
    // Check if can perform this activity
    override func canPerform(withActivityItems activityItems: [Any]) -> Bool {
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
    override func prepare(withActivityItems paramActivityItems: [Any]) {
        for object in paramActivityItems{
            if object is String{
                activityItems.append(object as! String as NSString)
            }
        }
    }
    
    func reverseOfString(_ string: NSString) -> NSString{
        
        var result = ""
        var characters = [Character]()
        
        for character in string as String{
            characters.append(character)
        }
        
        for character in characters.reversed(){
            result += "\(character)"
        }
        
        return result as NSString
        
    }

    
    override func perform() {
        var reversedStrings = ""
        
        for string in activityItems{
            reversedStrings += (reverseOfString(string) as String) + "\n"
        }
        
        /* Do whatever you need to do with all these
        reversed strings */
        print(reversedStrings)
    }
    
}
