//
//  ViewController.swift
//  Accessing the Music Library
//
//  Created by Domenico on 23/05/15.
//  License MIT
//

import UIKit
import MediaPlayer

class ViewController: UIViewController, MPMediaPickerControllerDelegate {

    var mediaPicker: MPMediaPickerController?
    
    func displayMediaPicker(){
        
        mediaPicker = MPMediaPickerController(mediaTypes: .Any)
        
        if let picker = mediaPicker{
            
            println("Successfully instantiated a media picker")
            picker.delegate = self
            picker.allowsPickingMultipleItems = false
            
            presentViewController(picker, animated: true, completion: nil)
            
        } else {
            println("Could not instantiate a media picker")
        }
        
    }
}

