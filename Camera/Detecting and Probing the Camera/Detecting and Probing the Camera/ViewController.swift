//
//  ViewController.swift
//  Detecting and Probing the Camera
//
//  Created by Domenico on 23/05/15.
//  License MIT
//

import UIKit
import MobileCoreServices

class ViewController: UIViewController {

    func isCameraAvailable() -> Bool{
        return UIImagePickerController.isSourceTypeAvailable(.Camera)
    }
    
    func isFrontCameraAvailable() -> Bool{
        return UIImagePickerController.isCameraDeviceAvailable(.Front)
    }
    
    func isRearCameraAvailable() -> Bool{
        return UIImagePickerController.isCameraDeviceAvailable(.Rear)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Camera is ")
        
        if isCameraAvailable() == false{
            print("not ")
        }
        
        println("available")
        
    }

}

