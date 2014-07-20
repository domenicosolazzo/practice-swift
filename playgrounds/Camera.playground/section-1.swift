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

// BeginConfiguration: Indicates the start of a set of configuration changes to be made atomically.
session.beginConfiguration()
// CommitConfiguration: Commits a set of configuration changes.
session.commitConfiguration()

// Used to capture data from an AVCaptureDevice obj
var input:AVCaptureDeviceInput! = nil
// Error variable
var err:NSError?

// Show the view
XCPShowView("camera", view)
