//
//  ViewController.swift
//  PinchMe
//
//  Created by Domenico on 01/05/15.
//  Copyright (c) 2015 Domenico. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIGestureRecognizerDelegate {

    fileprivate var imageView:UIImageView!
    fileprivate var scale:CGFloat = 1
    fileprivate var previousScale:CGFloat = 1
    fileprivate var rotation:CGFloat = 0
    fileprivate var previousRotation:CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let image = UIImage(named: "yosemite-meadows")
        imageView = UIImageView(image: image)
        imageView.isUserInteractionEnabled = true
        imageView.center = view.center
        view.addSubview(imageView)
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(ViewController.doPinch(_:)))
        pinchGesture.delegate = self
        imageView.addGestureRecognizer(pinchGesture)
        
        let rotationGesture = UIRotationGestureRecognizer(target: self, action: #selector(ViewController.doRotate(_:)))
        rotationGesture.delegate = self
        imageView.addGestureRecognizer(rotationGesture)
    }

    // It will allow both gesture recognizer to work together
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
        shouldRecognizeSimultaneouslyWith
        otherGestureRecognizer: UIGestureRecognizer) -> Bool {
            return true
    }
    
    // Helper method
    func transformImageView() {
        var t = CGAffineTransform(scaleX: scale * previousScale, y: scale * previousScale)
        t = t.rotated(by: rotation + previousRotation)
        imageView.transform = t
    }
    
    func doPinch(_ gesture:UIPinchGestureRecognizer) {
        scale = gesture.scale
        transformImageView()
        if gesture.state == .ended {
            previousScale = scale * previousScale
            scale = 1
        }
    }
    
    func doRotate(_ gesture:UIRotationGestureRecognizer) {
        rotation = gesture.rotation
        transformImageView()
        if gesture.state == .ended {
            previousRotation = rotation + previousRotation
            rotation = 0
        }
    }


}

