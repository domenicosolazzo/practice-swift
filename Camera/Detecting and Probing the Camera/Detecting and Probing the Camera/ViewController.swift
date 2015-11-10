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
    
    func isFlashAvailableOnFrontCamera() -> Bool{
        return UIImagePickerController.isFlashAvailableForCameraDevice(.Front)
    }
    
    func isFlashAvailableOnRearCamera() -> Bool{
        return UIImagePickerController.isFlashAvailableForCameraDevice(.Front)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Camera is ", terminator: "")
        
        if isCameraAvailable() == false{
            print("not ", terminator: "")
        }
        
        print("available")
        
    }

}

