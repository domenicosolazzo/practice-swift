//
//  ViewController.swift
//  Taking photos with the camera
//
//  Created by Domenico on 23/05/15.
//  License MIT
//

import UIKit
import MobileCoreServices

class ViewController: UIViewController,
       UINavigationControllerDelegate, UIImagePickerControllerDelegate{

    /* We use this variable to determine if the viewDidAppear:
    method of our view controller has been called or not. If not, we
    display the camera view */
    var beenHereBefore = false
    var controller: UIImagePickerController?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if beenHereBefore{
            /* Only display the picker once as the viewDidAppear: method gets
            called whenever the view of our view controller gets displayed */
            return;
        } else {
            beenHereBefore = true
        }
        
        if isCameraAvailable() && doesCameraSupportTakingPhotos(){
            
            controller = UIImagePickerController()
            
            if let theController = controller{
                theController.sourceType = .camera
                
                theController.mediaTypes = [kUTTypeImage as String]
                
                theController.allowsEditing = true
                theController.delegate = self
                
                present(theController, animated: true, completion: nil)
            }
            
        } else {
            print("Camera is not available")
        }
        
    }
    
    //- MARK: UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : Any]){
            
        print("Picker returned successfully")
            
        let mediaType:AnyObject? = info[UIImagePickerControllerMediaType] as AnyObject?
            
        if let type:AnyObject = mediaType{
                
            if type is String{
                let stringType = type as! String
                
                if stringType == kUTTypeMovie as String{
                    let urlOfVideo = info[UIImagePickerControllerMediaURL] as? URL
                    if let url = urlOfVideo{
                        print("Video URL = \(url)")
                    }
                }
                else if stringType == kUTTypeImage as String{
                    /* Let's get the metadata. This is only for images. Not videos */
                    let metadata = info[UIImagePickerControllerMediaMetadata]
                        as? NSDictionary
                    if let theMetaData = metadata{
                        // original image
                        let image = info[UIImagePickerControllerOriginalImage]
                            as? UIImage
                        // crop rect
                        let cropRect = info[UIImagePickerControllerCropRect]
                        // edited image
                        let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage
                        
                        if let theImage = image{
                            print("Image Metadata = \(theMetaData)")
                            print("Image = \(theImage)")
                            print("Edited image = \(editedImage)")
                            print("Crop Rect = \(cropRect)")
                        }
                    }
                }
                
            }
        }
            
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("Picker was cancelled")
        picker.dismiss(animated: true, completion: nil)
    }
    
    //- MARK: Helper methods
    func isCameraAvailable() -> Bool{
        return UIImagePickerController.isSourceTypeAvailable(.camera)
    }
    
    func cameraSupportsMedia(_ mediaType: String,
        sourceType: UIImagePickerControllerSourceType) -> Bool{
            
        let availableMediaTypes =
        UIImagePickerController.availableMediaTypes(for: sourceType) 
            
        if let types = availableMediaTypes{
            for type in types{
                if type == mediaType{
                    return true
                }
            }
        }
            
        return false
    }
    
    func doesCameraSupportTakingPhotos() -> Bool{
        return cameraSupportsMedia(kUTTypeImage as String, sourceType: .camera)
    }
}

