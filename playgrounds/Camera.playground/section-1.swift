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

/*
AVCaptureDevice
"An AVCaptureDevice object represents a physical capture device and the properties associated with that device. You use a capture device to configure the properties of the underlying hardware. A capture device also provides input data (such as audio or video) to an AVCaptureSession object.

You use the methods of the AVCaptureDevice class to enumerate the available devices, query their capabilities, and be informed about when devices come and go." - (https://developer.apple.com/library/ios/documentation/AVFoundation/Reference/AVCaptureDevice_Class/Reference/Reference.html#//apple_ref/occ/clm/AVCaptureDevice/devices)
*/
var devices: [AVCaptureDevice] = AVCaptureDevice.devices() as [AVCaptureDevice]

for device in devices{
    // Check if the device support video and the given session preset
    if device.hasMediaType(AVMediaTypeVideo) && device.supportsAVCaptureSessionPreset(AVCaptureSessionPreset640x480){
        // Returns an input initialized to use a specified device.
        input = AVCaptureDeviceInput.deviceInputWithDevice(device as AVCaptureDevice, error: &err) as AVCaptureDeviceInput
        
        // Check whether a given input can be added to the session.
        if session.canAddInput(input){
            session.addInput(input)
        }
    }
}

var settings = [kCVPixelBufferPixelFormatTypeKey:kCVPixelFormatType_32BGRA]

var videoOutput = AVCaptureVideoDataOutput()
// The compression settings for the video output
videoOutput.videoSettings = settings
// Indicates whether video frames are dropped if they arrive late. (Default: YES)
videoOutput.alwaysDiscardsLateVideoFrames = true

// Show the view
XCPShowView("camera", view)
