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
    let editFormatIdentifier = Bundle.main.bundleIdentifier
    let editFormatVersion = "0.1"
    
    /* A queue that will execute our edits in the background */
    let operationQueue = OperationQueue()
    
    let shouldShowCancelConfirmation: Bool = true
    
    /* This turns an image into its NSData representation */
    func dataFromCiImage(_ image: CIImage) -> Data{
        let glContext = EAGLContext(api: .openGLES2)
        let context = CIContext(eaglContext: glContext!)
        let imageRef = context.createCGImage(image, from: image.extent)
        let image = UIImage(cgImage: imageRef!, scale: 1.0, orientation: .up)
        return UIImageJPEGRepresentation(image, 1.0)!
    }
    
    /* This takes the input and converts it to the output. The output
    has our posterized content saved inside it */
    func posterizedImageForInput(_ input: PHContentEditingInput) ->
        PHContentEditingOutput{
            
            /* Get the required information from the asset */
            let url = input.fullSizeImageURL
            let orientation = input.fullSizeImageOrientation
            
            /* Retrieve an instance of CIImage to apply our filter to */
            let inputImage =
            CIImage(contentsOf: url!,
                options: nil)?.applyingOrientation(orientation)
            
            /* Apply the filter to our image */
            let filter = CIFilter(name: filterName)
            filter?.setDefaults()
            filter?.setValue(inputImage, forKey: kCIInputImageKey)
            let outputImage = filter?.outputImage
            
            /* Get the data of our edited image */
            let editedImageData = dataFromCiImage(outputImage!)
            
            /* The results of editing our image are encapsulated here */
            let output = PHContentEditingOutput(contentEditingInput: input)
            /* Here we are saving our edited image to the URL that is dictated
            by the content editing output class */
            do{
                try editedImageData.write(to:output.renderedContentURL,
                options: NSData.WritingOptions.atomicWrite)
            }catch{
                print("Error!")
            }
            output.adjustmentData =
                PHAdjustmentData(formatIdentifier: editFormatIdentifier!,
                    formatVersion: editFormatVersion,
                    data: filterName.data(using: String.Encoding.utf8,
                        allowLossyConversion: false)!)
            
            return output
            
    }
    
    /* We just want to work with the original image */
    func canHandle(_ adjustmentData: PHAdjustmentData) -> Bool {
        return false
    }
    
    /* This is a closure that we will submit to our operation queue */
    func editingOperation(){
        
        output = posterizedImageForInput(input!)
        
        DispatchQueue.main.async(execute: {[weak self] in
            let strongSelf = self!
            
            let data = try? Data(contentsOf: strongSelf.output.renderedContentURL,
                options: .mappedIfSafe)
            
            let image = UIImage(data: data!)
            
            strongSelf.imageView.image = image
            })
    }
    
    func startContentEditing(
        with contentEditingInput: PHContentEditingInput,
        placeholderImage: UIImage) {
            
            imageView.image = placeholderImage
            input = contentEditingInput
            
            /* Start the editing in the background */
            let block = BlockOperation(block: editingOperation)
            operationQueue.addOperation(block)
            
    }
    
    func finishContentEditing(
        completionHandler: @escaping (PHContentEditingOutput?) -> Void) {
            /* Report our output */
            completionHandler(output)
    }
    
    /* The user cancelled the editing process */
    func cancelContentEditing() {
        /* Make sure we stop our operation here */
        operationQueue.cancelAllOperations()
    }

}
