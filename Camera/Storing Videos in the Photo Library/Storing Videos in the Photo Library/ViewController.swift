//
//  ViewController.swift
//  Storing Videos in the Photo Library
//
//  Created by Domenico on 23/05/15.
//  License MIT
//

import UIKit
import AssetsLibrary

class ViewController: UIViewController {

    var assetsLibrary: ALAssetsLibrary?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        assetsLibrary = ALAssetsLibrary()
        
        let videoURL = NSBundle.mainBundle().URLForResource("sample_iTunes",
            withExtension: "mov") as NSURL?
        
        if let library = assetsLibrary{
            
            if let url = videoURL{
                
                library.writeVideoAtPathToSavedPhotosAlbum(url,
                    completionBlock: {(url: NSURL!, error: NSError!) in
                        
                        println(url)
                        
                        if let theError = error{
                            println("Error happened while saving the video")
                            println("The error is = \(theError)")
                        } else {
                            println("no errors happened")
                        }
                        
                })
            } else {
                println("Could not find the video in the app bundle")
            }
            
        }
    }
}

