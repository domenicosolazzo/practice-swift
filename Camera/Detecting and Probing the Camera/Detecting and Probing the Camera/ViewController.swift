//
//  ViewController.swift
//  Detecting and Probing the Camera
//
//  Created by Domenico on 23/05/15.
//  License MIT
//

import UIKit

class ViewController: UIViewController {

    func isCameraAvailable() -> Bool{
        
        return UIImagePickerController.isSourceTypeAvailable(.Camera)
        
    }

}

