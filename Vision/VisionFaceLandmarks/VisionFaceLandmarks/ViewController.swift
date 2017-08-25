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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

