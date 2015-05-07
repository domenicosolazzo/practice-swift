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
    
    func editAsset(asset: PHAsset){
        /* Can we handle previous edits on this asset? */
        let requestOptions = PHContentEditingInputRequestOptions()
        requestOptions.canHandleAdjustmentData = {
            [weak self] (data: PHAdjustmentData!) -> Bool in
            /* Yes, but only if they are our edits */
            if data.formatIdentifier == self!.editFormatIdentifier &&
                data.formatVersion == self!.editFormatVersion{
                return true
            }else{
                return false
            }
        }
        
        /* Now ask the system if we are allowed to edit the given asset */
        asset.requestContentEditingInputWithOptions(requestOptions,
            completionHandler: {[weak self](input: PHContentEditingInput!,
                info: [NSObject : AnyObject]!) in
                
                /* Get the required information from the asset */
                let url = input.fullSizeImageURL
                let orientation = input.fullSizeImageOrientation
                
                /* Retrieve an instance of CIImage to apply our filter */
                let inputImage = CIImage(contentsOfURL: url, options:nil)
                    .imageByApplyingOrientation(orientation)
                
                /* Apply the filter to our image */
                let filter = CIFilter(name: self!.filterName)
                filter.setDefaults()
                filter.setValue(inputImage, forKey: kCIInputImageKey)
                let outputImage = filter.outputImage
                
                /* Get the data of our edited image */
                let editedImageData = self!.dataFromCIImage(outputImage)
                
                /* The results of editing our image are encapsulated here */
                let output = PHContentEditingOutput(contentEditingInput: input)
                
                /* Here we are saving our edited image to the URL that is dictated
                by the content editing output class */
                editedImageData.writeToURL(output.renderedContentURL, atomically: true)
                
                output.adjustmentData = PHAdjustmentData(
                    formatIdentifier: self!.editFormatIdentifier,
                    formatVersion: self!.editFormatVersion,
                    data: self!.filterName.dataUsingEncoding(
                        NSUTF8StringEncoding,
                        allowLossyConversion: false)
                )
                
                /* Now perform our changes */
                PHPhotoLibrary.sharedPhotoLibrary().performChanges({
                    /* This is the change object and its output is the output object
                        that we created previously */
                    let change = PHAssetChangeRequest(forAsset: asset)
                    change.contentEditingOutput = output
                    }, completionHandler: {[weak self](success:Bool, error: NSError) in
                        self!.performOnMainThread{
                            if success{
                                self!.displayAlertWithTitle("Succeeded", message: "Successfully edited the image")
                            }else{
                                self!.displayAlertWithTitle("Failed", message: "Could not edit the image. Error = \(error)")
                            }
                        }
                    })
            
        })
    }
    
    /*
        A little handy method that allows us to perform a block object
        on the main thread
    */
    func performOnMainThread(block: dispatch_block_t){
        dispatch_async(dispatch_get_main_queue(), block)
    }
    
    
    /* Just a little method to help us display alert dialogs to the user */
    func displayAlertWithTitle(title: String, message: String){
        let controller = UIAlertController(title: title,
            message: message,
            preferredStyle: .Alert)
        
        controller.addAction(UIAlertAction(title: "OK",
            style: .Default,
            handler: nil))
        
        presentViewController(controller, animated: true, completion: nil)
        
    }
}

