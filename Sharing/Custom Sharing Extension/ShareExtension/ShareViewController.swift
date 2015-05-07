//
//  ShareViewController.swift
//  ShareExtension
///
//  Created by Domenico Solazzo on 07/05/15.
//  License MIT
//

import UIKit
import Social
import MobileCoreServices

class ShareViewController: SLComposeServiceViewController,
AudienceSelectionViewControllerDelegate, NSURLSessionDelegate  {

    
    var imageData: NSData?
    
    // Used from to iOS to ask to your view controller if it must enable the 
    // Post button
    override func isContentValid() -> Bool {
        /* The post button should be enabled only if we have the image data
        and the user has entered at least one character of text */
        if let data = imageData{
            if count(contentText) > 0{
                return true
            }
        }
        
        return false
    }
    
    // It gets called just as our view controller is fully displayed on the screen.
    override func presentationAnimationDidFinish() {
        super.presentationAnimationDidFinish()
        
        placeholder = "Your comments"
        
        let content = extensionContext!.inputItems[0] as! NSExtensionItem
        let contentType = kUTTypeImage as! String
        
        for attachment in content.attachments as! [NSItemProvider]{
            if attachment.hasItemConformingToTypeIdentifier(contentType){
                
                let dispatchQueue =
                dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
                
                dispatch_async(dispatchQueue, {[weak self] in
                    
                    let strongSelf = self!
                    
                    attachment.loadItemForTypeIdentifier(contentType,
                        options: nil,
                        completionHandler: {(content: NSSecureCoding!, error: NSError!) in
                            if let data = content as? NSData{
                                dispatch_async(dispatch_get_main_queue(), {
                                    strongSelf.imageData = data
                                    strongSelf.validateContent()
                                })
                            }
                    })
                    
                    })
                
            }
            
            break
        }
        
    }
    
    // Whenever the user click the Post button
    override func didSelectPost() {
        
        let identifier = NSBundle.mainBundle().bundleIdentifier! + "." +
            NSUUID().UUIDString
        
        let configuration =
        NSURLSessionConfiguration.backgroundSessionConfigurationWithIdentifier(
            identifier)
        
        let session = NSURLSession(configuration: configuration,
            delegate: self,
            delegateQueue: nil)
        
        let url = NSURL(string: "https://www.domenicosolazzo.com/&text=" +
            self.contentText)
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "POST"
        request.HTTPBody = imageData!
        
        let task = session.uploadTaskWithRequest(request,
            fromData: request.HTTPBody)
        
        task.resume()
        
        extensionContext!.completeRequestReturningItems([], completionHandler: nil)
    }
    
    // what the sharing extension displays as extra configuration items
    lazy var audienceConfigurationItem: SLComposeSheetConfigurationItem = {
        let item = SLComposeSheetConfigurationItem()
        item.title = "Audience"
        item.value = AudienceSelectionViewController.defaultAudience()
        item.tapHandler = self.showAudienceSelection
        return item
        }()
    
    override func configurationItems() -> [AnyObject]! {
        return [audienceConfigurationItem]
    }
}
