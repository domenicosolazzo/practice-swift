//
//  ViewController.swift
//  Taking photos with the camera
//
//  Created by Domenico on 23/05/15.
//  License MIT
//

import UIKit

class ViewController: UIViewController,
       UINavigationControllerDelegate, UIImagePickerControllerDelegate{

    /* We use this variable to determine if the viewDidAppear:
    method of our view controller has been called or not. If not, we
    display the camera view */
    var beenHereBefore = false
    var controller: UIImagePickerController?
    
    //- MARK: Helper methods
    func isCameraAvailable() -> Bool{
        return UIImagePickerController.isSourceTypeAvailable(.Camera)
    }
}

