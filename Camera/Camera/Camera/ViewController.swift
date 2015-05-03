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
        if !UIImagePickerController.isSourceTypeAvailable(
            UIImagePickerControllerSourceType.Camera) {
                takePictureButton.hidden = true
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        updateDisplay()
    }

    
    
    @IBAction func shootPictureOrVideo(sender: UIButton) {
    }
    
    @IBAction func selectExistingPictureOrVideo(sender: UIButton) {
    }
    
    func updateDisplay() {
        if let mediaType = lastChosenMediaType {
            if mediaType == kUTTypeImage as NSString {
                imageView.image = image!
                imageView.hidden = false
                if moviePlayerController != nil {
                    moviePlayerController!.view.hidden = true
                }
            } else if mediaType == kUTTypeMovie as NSString {
                if moviePlayerController == nil {
                    moviePlayerController =
                        MPMoviePlayerController(contentURL: movieURL)
                    let movieView = moviePlayerController!.view
                    movieView.frame = imageView.frame
                    movieView.clipsToBounds = true
                    view.addSubview(movieView)
                    setMoviePlayerLayoutConstraints()
                } else {
                    moviePlayerController!.contentURL = movieURL
                }
                imageView.hidden = true
                moviePlayerController!.view.hidden = false
                moviePlayerController!.play()
            }
        }
    }


}

