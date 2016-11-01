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
        return UIImagePickerController.isSourceTypeAvailable(.camera)
    }
    
    func isFrontCameraAvailable() -> Bool{
        return UIImagePickerController.isCameraDeviceAvailable(.front)
    }
    
    func isRearCameraAvailable() -> Bool{
        return UIImagePickerController.isCameraDeviceAvailable(.rear)
    }
    
    func isFlashAvailableOnFrontCamera() -> Bool{
        return UIImagePickerController.isFlashAvailable(for: .front)
    }
    
    func isFlashAvailableOnRearCamera() -> Bool{
        return UIImagePickerController.isFlashAvailable(for: .front)
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

