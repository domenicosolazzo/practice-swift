// Playground: UIKit
import UIKit

/**
==== UIView ====
*/
var v = UIView(frame: CGRectMake(0,0, 200,200))

/** 
==== Button ====
*/
var b = UIButton(frame: CGRectMake(0,0,100,30))
// Set the title
b.setTitle("Domenico Button", forState: UIControlState.Normal)
// Set the title color
b.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)