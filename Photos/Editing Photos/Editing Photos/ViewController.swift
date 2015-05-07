//
//  ViewController.swift
//  Editing Photos
//
//  Created by Domenico Solazzo on 07/05/15.
//  License MIT
//

import UIKit
import Photos
import OpenGLES

class ViewController: UIViewController {

    /* These two values are our way of telling the Photos framework about
    the identifier of the changes that we are going to make to the photo */
    let editFormatIdentifier = NSBundle.mainBundle().bundleIdentifier;
    /* Just an application-specific editing version */
    let editFormatVersion = "0.1"
    /* This is our filter name. We will use this for our Core Image filter */
    let filterName = "CIColorPosterize"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* Pick the newest photo in the photo library */
        PHPhotoLibrary.requestAuthorization{
            [weak self](status: PHAuthorizationStatus) in
            
            dispatch_async(dispatch_get_main_queue()){
                switch status{
                case .Authorized:
                    self!.retrieveNewestImage()
                default:
                    self!.displayAlertWithTitle("Access",
                        message: "I could not access the Photo Library")
                }
            }
        }
    }
    
    //- MARK: Helpers
    // Fetch NSData from an image. It uses OpenGL
    func dataFromCIImage(image:CIImage) -> NSData{
        let glContext = EAGLContext(API: EAGLRenderingAPI.OpenGLES2)
        let context = CIContext(EAGLContext: glContext)
        let imageRef = context.createCGImage(image, fromRect: image.extent())
        let image = UIImage(CGImage: imageRef, scale: 1.0, orientation: .Up)
        return UIImageJPEGRepresentation(image, 1.0)
    }
    
    /* After this method retrieves the newest image from the user's assets
    library, it will attempt to edit it */
    func retrieveNewestImage(){
        let options = PHFetchOptions()
        options.sortDescriptors = [NSSortDescriptor(key: "CreationDate", ascending: true)]
        
        /* 
            Then get an object of type PHFetchResult that will contain
            all of our image assets 
        */
        let assetResults = PHAsset.fetchAssetsWithMediaType(PHAssetMediaType.Image, options: options)
        
        if assetResults == nil{
            println("Found no results")
            return
        } else{
            println("Found \(assetResults.count) results")
        }
        
        let imageManager = PHCachingImageManager()
        
        if let asset = assetResults[0] as? PHAsset{
            editAsset(asset)
        }
    }
    
    /*
        A little handy method that allows us to perform a block object
        on the main thread
    */
    func performOnMainThread(block: dispatch_block_t){
        dispatch_async(dispatch_get_main_queue(), block)
    }
}

