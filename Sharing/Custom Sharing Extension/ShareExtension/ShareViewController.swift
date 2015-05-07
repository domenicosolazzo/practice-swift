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
}
