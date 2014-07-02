// Playground: Drawing with Swift
// Source: http://goo.gl/MYRQJl

import Cocoa
import XCPlayground

/**
==== Create a Rectangle ====
*/
var x = 0
var y = 0
var width = 300
var height = 300
var frameRect = NSRect(x: x,y: y,width: width, height: height)

/**
==== Image View ====
*/
var view = NSImageView(frame: frameRect)