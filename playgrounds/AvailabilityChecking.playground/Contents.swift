//: Availability Checking
// Describing how to use the new availability checking feature in iOS9

import UIKit

/**
 * How to check an OS version before Swift 2
 *
if NSProcessInfo().isOperatingSystemAtLeastVersion(NSOperatingSystemVersion(majorVersion: 9, minorVersion: 0, patchVersion: 0)) {
    print("Create the stack view!")
}
*/

if #available(iOS 9, *){
    // Use iOS 9 framework, or any other unknown platforms like watchOS
    // * => Unknown platform
}else{
    // Use iOS 8
}

func myMethod(){
    guard #available(iOS 9, *) else {
        return // Run this code if you are not in iOS 9 or later
    }
    
}


// This method is only available for iOS 9
@available(iOS 9, *)
func useStackView() {
    // use UIStackView
}


// Stacking the available keyword
@available(iOS 9, *)
func iOS9Work(){

}

@available(iOS 8, *)
func iOS8Work() {
    // do stuff
    if #available(iOS 9, *) {
        iOS9Work()
    }
}


