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
        
        let videoURL = Bundle.main.url(forResource: "sample_iTunes",
            withExtension: "mov") as URL?
        
        if let library = assetsLibrary{
            
            if let url = videoURL{
                
                library.writeVideoAtPath(toSavedPhotosAlbum: url,
                    completionBlock: {(url: URL!, error: NSError?) in
                        
                        print(url)
                        
                        if let theError = error{
                            print("Error happened while saving the video")
                            print("The error is = \(theError)")
                        } else {
                            print("no errors happened")
                        }
                        
                })
            } else {
                print("Could not find the video in the app bundle")
            }
            
        }
    }
}

