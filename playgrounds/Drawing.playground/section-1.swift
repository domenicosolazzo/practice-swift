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
var dogPictureUrl = NSURL(string: "https://openclipart.org/image/300px/svg_to_png/190758/lemmling_Cartoon_dog_Laughing.png")

// Get the picture
var dogPicture = NSImage(contentsOfURL: dogPictureUrl)

// Tell the view which image to display
view.image = dogPicture

// Tell the playground to show the picture
XCPShowView("DoG", view)

var size = NSMakeSize(300, 300)
var img = NSImage(size)