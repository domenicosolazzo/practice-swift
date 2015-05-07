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

class PhotoEditingViewController: UIViewController, PHContentEditingController {

    /* 
        An image view on the screen that first shows the original
        image to the user; after we are done applying our edits
        it will show the edited image
    */
    @IBOutlet weak var imageWiew: UIImageView!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - PHContentEditingController

    func canHandleAdjustmentData(adjustmentData: PHAdjustmentData?) -> Bool {
        // Inspect the adjustmentData to determine whether your extension can work with past edits.
        // (Typically, you use its formatIdentifier and formatVersion properties to do this.)
        return false
    }

    func startContentEditingWithInput(contentEditingInput: PHContentEditingInput?, placeholderImage: UIImage) {
        // Present content for editing, and keep the contentEditingInput for use when closing the edit session.
        // If you returned YES from canHandleAdjustmentData:, contentEditingInput has the original image and adjustment data.
        // If you returned NO, the contentEditingInput has past edits "baked in".
        input = contentEditingInput
    }

    func finishContentEditingWithCompletionHandler(completionHandler: ((PHContentEditingOutput!) -> Void)!) {
        // Update UI to reflect that editing has finished and output is being rendered.
        
        // Render and provide output on a background queue.
        dispatch_async(dispatch_get_global_queue(CLong(DISPATCH_QUEUE_PRIORITY_DEFAULT), 0)) {
            // Create editing output from the editing input.
            let output = PHContentEditingOutput(contentEditingInput: self.input)
            
            // Provide new adjustments and render output to given location.
            // output.adjustmentData = <#new adjustment data#>
            // let renderedJPEGData = <#output JPEG#>
            // renderedJPEGData.writeToURL(output.renderedContentURL, atomically: true)
            
            // Call completion handler to commit edit to Photos.
            completionHandler?(output)
            
            // Clean up temporary files, etc.
        }
    }

    var shouldShowCancelConfirmation: Bool {
        // Determines whether a confirmation to discard changes should be shown to the user on cancel.
        // (Typically, this should be "true" if there are any unsaved changes.)
        return false
    }

    func cancelContentEditing() {
        // Clean up temporary files, etc.
        // May be called after finishContentEditingWithCompletionHandler: while you prepare output.
    }

}
