//
//  PhotoEditingViewController.swift
//  PhotoEditExtension
//
//  Created by Domenico Solazzo on 06/05/15.
//  License MIT
//

import UIKit
import Photos
import PhotosUI
import OpenGLES

class PhotoEditingViewController: UIViewController, PHContentEditingController {

    /* 
        An image view on the screen that first shows the original
        image to the user; after we are done applying our edits
        it will show the edited image
    */
    @IBOutlet weak var imageView: UIImageView!
    
    /* The input that the system will give us */
    var input: PHContentEditingInput?

    /* We give our edits to the user in this way */
    var output:  PHContentEditingOutput!
    
    /* We give our edits to the user in this way */
    let filterName = "CIColorPosterize"
    
    /* How we are telling to the Photos framework who is editing the photo */
    let editFormatIdentifier = NSBundle.mainBundle().bundleIdentifier
    let editFormatVersion = "0.1"
    
    /* A queue that will execute our edits in the background */
    let operationQueue = NSOperationQueue()
    
    let shouldShowCancelConfirmation: Bool = true
    
    /* This turns an image into its NSData representation */
    func dataFromCiImage(image: CIImage) -> NSData{
        let glContext = EAGLContext(API: .OpenGLES2)
        let context = CIContext(EAGLContext: glContext)
        let imageRef = context.createCGImage(image, fromRect: image.extent)
        let image = UIImage(CGImage: imageRef, scale: 1.0, orientation: .Up)
        return UIImageJPEGRepresentation(image, 1.0)
    }
    
    /* This takes the input and converts it to the output. The output
    has our posterized content saved inside it */
    func posterizedImageForInput(input: PHContentEditingInput) ->
        PHContentEditingOutput{
            
            /* Get the required information from the asset */
            let url = input.fullSizeImageURL
            let orientation = input.fullSizeImageOrientation
            
            /* Retrieve an instance of CIImage to apply our filter to */
            let inputImage =
            CIImage(contentsOfURL: url,
                options: nil).imageByApplyingOrientation(orientation)
            
            /* Apply the filter to our image */
            let filter = CIFilter(name: filterName)
            filter.setDefaults()
            filter.setValue(inputImage, forKey: kCIInputImageKey)
            let outputImage = filter.outputImage
            
            /* Get the data of our edited image */
            let editedImageData = dataFromCiImage(outputImage)
            
            /* The results of editing our image are encapsulated here */
            let output = PHContentEditingOutput(contentEditingInput: input)
            /* Here we are saving our edited image to the URL that is dictated
            by the content editing output class */
            editedImageData.writeToURL(output.renderedContentURL,
                atomically: true)
            
            output.adjustmentData =
                PHAdjustmentData(formatIdentifier: editFormatIdentifier,
                    formatVersion: editFormatVersion,
                    data: filterName.dataUsingEncoding(NSUTF8StringEncoding,
                        allowLossyConversion: false))
            
            return output
            
    }
    
    /* We just want to work with the original image */
    func canHandleAdjustmentData(adjustmentData: PHAdjustmentData?) -> Bool {
        return false
    }
    
    /* This is a closure that we will submit to our operation queue */
    func editingOperation(){
        
        output = posterizedImageForInput(input!)
        
        dispatch_async(dispatch_get_main_queue(), {[weak self] in
            let strongSelf = self!
            
            let data = try? NSData(contentsOfURL: strongSelf.output.renderedContentURL,
                options: .DataReadingMappedIfSafe)
            
            let image = UIImage(data: data!)
            
            strongSelf.imageView.image = image
            })
    }
    
    func startContentEditingWithInput(
        contentEditingInput: PHContentEditingInput?,
        placeholderImage: UIImage) {
            
            imageView.image = placeholderImage
            input = contentEditingInput
            
            /* Start the editing in the background */
            let block = NSBlockOperation(block: editingOperation)
            operationQueue.addOperation(block)
            
    }
    
    func finishContentEditingWithCompletionHandler(
        completionHandler: ((PHContentEditingOutput!) -> Void)!) {
            /* Report our output */
            completionHandler(output)
    }
    
    /* The user cancelled the editing process */
    func cancelContentEditing() {
        /* Make sure we stop our operation here */
        operationQueue.cancelAllOperations()
    }

}
