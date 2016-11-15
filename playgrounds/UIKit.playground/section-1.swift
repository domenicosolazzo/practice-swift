// Playground: UIKit
import UIKit

/**
==== UIView ====
*/
var v = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))

/** 
==== Button ====
*/

var b = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
// Set the title
b.setTitle("Dome here", for: UIControlState.normal)
// Set the title color
b.setTitleColor(UIColor.blue, for: UIControlState.normal)

// Add the button to the subview
v.addSubview(b)

// Show the view
v
