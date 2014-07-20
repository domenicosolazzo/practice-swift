import Cocoa
import AVFoundation
import AVKit
import QuartzCore
import XCPlayground

// Creating a new view
var view = NSView(frame: NSRect(x:0, y:0, width:640, height:480))

// Creating an AVCaptureSession
var session = AVCaptureSession()

// SessionPreset: A constant value indicating the quality level or bitrate of the output.
session.sessionPreset = AVCaptureSessionPreset640x480


// Show the view
XCPShowView("camera", view)
