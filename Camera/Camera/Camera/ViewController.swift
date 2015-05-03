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
        pickMediaFromSource(UIImagePickerControllerSourceType.Camera)
    }
    
    @IBAction func selectExistingPictureOrVideo(sender: UIButton) {
        pickMediaFromSource(UIImagePickerControllerSourceType.PhotoLibrary)
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
    
    func setMoviePlayerLayoutConstraints() {
        let moviePlayerView = moviePlayerController!.view
        moviePlayerView.setTranslatesAutoresizingMaskIntoConstraints(false)
        let views = ["moviePlayerView": moviePlayerView,
            "takePictureButton": takePictureButton]
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|[moviePlayerView]|", options:NSLayoutFormatOptions(0),
            metrics:nil, views:views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|[moviePlayerView]-0-[takePictureButton]",
            options:NSLayoutFormatOptions(0), metrics:nil, views:views))
    }
    
    func pickMediaFromSource(sourceType:UIImagePickerControllerSourceType) {
        let mediaTypes =
        UIImagePickerController.availableMediaTypesForSourceType(sourceType)!
        if UIImagePickerController.isSourceTypeAvailable(sourceType)
            && mediaTypes.count > 0 {
                let picker = UIImagePickerController()
                picker.mediaTypes = mediaTypes
                picker.delegate = self
                picker.allowsEditing = true
                picker.sourceType = sourceType
                presentViewController(picker, animated: true, completion: nil)
        } else {
            let alertController = UIAlertController(title:"Error accessing media",
                message: "Unsupported media source.",
                preferredStyle: UIAlertControllerStyle.Alert)
            let okAction = UIAlertAction(title: "OK",
                style: UIAlertActionStyle.Cancel, handler: nil)
            alertController.addAction(okAction)
            presentViewController(alertController, animated: true, completion: nil)
        }
    }


}

