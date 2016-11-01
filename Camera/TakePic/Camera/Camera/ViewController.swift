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
    var movieURL:URL?
    var lastChosenMediaType:String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if !UIImagePickerController.isSourceTypeAvailable(
            UIImagePickerControllerSourceType.camera) {
                takePictureButton.isHidden = true
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateDisplay()
    }

    
    
    @IBAction func shootPictureOrVideo(_ sender: UIButton) {
        pickMediaFromSource(UIImagePickerControllerSourceType.camera)
    }
    
    @IBAction func selectExistingPictureOrVideo(_ sender: UIButton) {
        pickMediaFromSource(UIImagePickerControllerSourceType.photoLibrary)
    }
    
    func updateDisplay() {
        if let mediaType = lastChosenMediaType {
            if mediaType == (kUTTypeImage as NSString) as String {
                imageView.image = image!
                imageView.isHidden = false
                if moviePlayerController != nil {
                    moviePlayerController!.view.isHidden = true
                }
            } else if mediaType == (kUTTypeMovie as NSString) as String {
                if moviePlayerController == nil {
                    moviePlayerController =
                        MPMoviePlayerController(contentURL: movieURL)
                    let movieView = moviePlayerController!.view
                    movieView?.frame = imageView.frame
                    movieView?.clipsToBounds = true
                    view.addSubview(movieView!)
                    setMoviePlayerLayoutConstraints()
                } else {
                    moviePlayerController!.contentURL = movieURL
                }
                imageView.isHidden = true
                moviePlayerController!.view.isHidden = false
                moviePlayerController!.play()
            }
        }
    }
    
    func setMoviePlayerLayoutConstraints() {
        let moviePlayerView = moviePlayerController!.view
        moviePlayerView?.translatesAutoresizingMaskIntoConstraints = false
        let views = ["moviePlayerView": moviePlayerView,
            "takePictureButton": takePictureButton]
        view.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|[moviePlayerView]|", options:NSLayoutFormatOptions(rawValue: 0),
            metrics:nil, views:views))
        view.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|[moviePlayerView]-0-[takePictureButton]",
            options:NSLayoutFormatOptions(rawValue: 0), metrics:nil, views:views))
    }
    
    func pickMediaFromSource(_ sourceType:UIImagePickerControllerSourceType) {
        let mediaTypes =
        UIImagePickerController.availableMediaTypes(for: sourceType)!
        if UIImagePickerController.isSourceTypeAvailable(sourceType)
            && mediaTypes.count > 0 {
                let picker = UIImagePickerController()
                picker.mediaTypes = mediaTypes
                picker.delegate = self
                picker.allowsEditing = true
                picker.sourceType = sourceType
                present(picker, animated: true, completion: nil)
        } else {
            let alertController = UIAlertController(title:"Error accessing media",
                message: "Unsupported media source.",
                preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "OK",
                style: UIAlertActionStyle.cancel, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        }
    }
    
    //- MARK: UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        lastChosenMediaType = info[UIImagePickerControllerMediaType] as! NSString as String
        if let mediaType = lastChosenMediaType {
            if mediaType == (kUTTypeImage as NSString) as String {
                image = info[UIImagePickerControllerEditedImage] as? UIImage
            } else if mediaType == (kUTTypeMovie as NSString) as String {
                movieURL = info[UIImagePickerControllerMediaURL] as? URL
            }
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion:nil)
    }


}

