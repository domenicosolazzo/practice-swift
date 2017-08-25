//
//  ViewController.swift
//  VisionFaceLandmarks
//
//  Created by Domenico Solazzo on 8/25/17.
//  Copyright © 2017 Domenico Solazzo. All rights reserved.
//

import UIKit
import AVFoundation
import Vision

class ViewController: UIViewController {
    // AVCapture Session
    var session: AVCaptureSession?
    // Shape Layer
    let shapeLayer = CAShapeLayer()
    
    // Vision requests
    let faceDetection = VNDetectFaceRectanglesRequest()
    // Face Landmarks request
    let faceLandmarks = VNDetectFaceLandmarksRequest()
    // Face Detection request handler
    let faceDetectionRequest = VNSequenceRequestHandler()
    // Face Landmarks request handler
    let faceLandmarksRequest = VNSequenceRequestHandler()
    
    
    // Preview Layer
    lazy var previewLayer: AVCaptureVideoPreviewLayer? = {
        // Check if the AVCapture session is initialized, otherwise return nil
        guard let session = self.session else { return nil }
        
        // Create the preview layer
        var previewLayer = AVCaptureVideoPreviewLayer(session: session)
        // Set the aspect of the preview video
        previewLayer.videoGravity = .resizeAspectFill
        return previewLayer
    }()
    
    // Camera to use
    var frontCamera: AVCaptureDevice? = {
        return AVCaptureDevice.default(AVCaptureDevice.DeviceType.builtInWideAngleCamera, for: .video, position: AVCaptureDevice.Position.front)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        sessionPrepare()
        session?.startRunning()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        previewLayer?.frame = view.frame
        shapeLayer.frame = view.frame
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let previewLayer = previewLayer else { return }
        
        view.layer.addSublayer(previewLayer)
        
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.lineWidth = 2.0
        
        //needs to filp coordinate system for Vision
        shapeLayer.setAffineTransform(CGAffineTransform(scaleX: -1, y: -1))
        
        view.layer.addSublayer(shapeLayer)
    }

    // Prepare the session
    func sessionPrepare() {
        session = AVCaptureSession()
        guard let session = session, let captureDevice = frontCamera else { return  }
        
        do {
            let deviceInput = try AVCaptureDeviceInput(device: captureDevice)
            session.beginConfiguration()
            
            if session.canAddInput(deviceInput) {
                session.addInput(deviceInput)
            }
            
            let output = AVCaptureVideoDataOutput()
            output.videoSettings = [
                String(kCVPixelBufferPixelFormatTypeKey): Int(kCVPixelFormatType_420YpCbCr8BiPlanarFullRange)
            ]
            
            output.alwaysDiscardsLateVideoFrames = true
            
            if session.canAddOutput(output) {
                session.addOutput(output)
            }
            
            session.commitConfiguration()
            
            let queue = DispatchQueue(label: "output.queue")
            output.setSampleBufferDelegate(self, queue: queue)
            print("Setup delegate")
        } catch {
            print("Can't setup session")
        }
    }

}

extension ViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        
        let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)
        
        let attachments = CMCopyDictionaryOfAttachments(kCFAllocatorDefault, sampleBuffer, kCMAttachmentMode_ShouldPropagate)
        let ciImage = CIImage(cvImageBuffer: pixelBuffer!, options: attachments as! [String : Any]?)
        
        //leftMirrored for front camera
        let ciImageWithOrientation = ciImage.oriented(forExifOrientation: Int32(UIImageOrientation.leftMirrored.rawValue))
        
        
    }
    
}

