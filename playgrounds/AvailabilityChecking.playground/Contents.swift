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


