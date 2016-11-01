//
//  ViewController.swift
//  Storing Photos in the Photo Library
//
//  Created by Domenico on 23/05/15.
//  License MIT
//

import UIKit
import MobileCoreServices

class ViewController: UIViewController,
    UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    /* We will use this variable to determine if the viewDidAppear:
    method of our view controller is already called or not. If not, we will
    display the camera view */
    var beenHereBefore = false
    var controller: UIImagePickerController?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if beenHereBefore{
            /* Only display the picker once as the viewDidAppear: method gets
            called whenever the view of our view controller gets displayed */
            return
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
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        
        print("Picker was cancelled")
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    func imageWasSavedSuccessfully(_ image: UIImage,
        didFinishSavingWithError error: NSError!,
        context: UnsafeMutableRawPointer){
            
        if let theError = error{
            print("An error happened while saving the image = \(theError)")
        } else {
            print("Image was saved successfully")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : Any]){
            
            print("Picker returned successfully")
            
            let mediaType:AnyObject? = info[UIImagePickerControllerMediaType] as AnyObject?
            
            if let type:AnyObject = mediaType{
                
                if type is String{
                    let stringType = type as! String
                    
                    if stringType == kUTTypeImage as String{
                        
                        var theImage: UIImage!
                        
                        if picker.allowsEditing{
                            theImage = info[UIImagePickerControllerEditedImage] as! UIImage
                        } else {
                            theImage = info[UIImagePickerControllerOriginalImage] as! UIImage
                        }
                        
                        
                        let selectorAsString =
                        "imageWasSavedSuccessfully:didFinishSavingWithError:context:"
                        
                        let selectorToCall = Selector(selectorAsString)
                        
                        UIImageWriteToSavedPhotosAlbum(theImage,
                            self,
                            selectorToCall,
                            nil)
                        
                    }
                    
                }
            }
            
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

