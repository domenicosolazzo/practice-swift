import Cocoa
import AVFoundation
import AVKit
import QuartzCore
import XCPlayground

// Creating a new view
var view = NSView(frame: NSRect(x:0, y:0, width:640, height:480))

// Creating an AVCaptureSession
var session = AVCaptureSession()


// Show the view
XCPShowView("camera", view)
