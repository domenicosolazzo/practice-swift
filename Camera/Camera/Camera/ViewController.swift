//
//  ViewController.swift
//  Camera
//
//  Created by Domenico on 03/05/15.
//  Copyright (c) 2015 Domenico. All rights reserved.
//

import UIKit
import MediaPlayer
import MobileCoreServices

class ViewController: UIViewController, UIImagePickerControllerDelegate,
            UINavigationControllerDelegate {
    @IBOutlet var imageView:UIImageView!
    @IBOutlet var takePictureButton:UIButton!
    
    // In case the user want to take a new video
    var moviePlayerController:MPMoviePlayerController?
    var image:UIImage?
    var movieURL:NSURL?
    var lastChosenMediaType:String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func shootPictureOrVideo(sender: UIButton) {
    }
    
    @IBAction func selectExistingPictureOrVideo(sender: UIButton) {
    }


}

