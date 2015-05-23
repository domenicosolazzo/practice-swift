//
//  ViewController.swift
//  Accessing the Music Library
//
//  Created by Domenico on 23/05/15.
//  License MIT
//

import UIKit
import MediaPlayer

class ViewController: UIViewController, MPMediaPickerControllerDelegate {

    var mediaPicker: MPMediaPickerController?
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        displayMediaPicker()
    }
    
    func displayMediaPicker(){
        
        mediaPicker = MPMediaPickerController(mediaTypes: .Any)
        
        if let picker = mediaPicker{
            
            println("Successfully instantiated a media picker")
            picker.delegate = self
            picker.allowsPickingMultipleItems = false
            
            presentViewController(picker, animated: true, completion: nil)
            
        } else {
            println("Could not instantiate a media picker")
        }
        
    }
    
    //- MARK: MPMediaPickerControllerDelegate
    func mediaPicker(mediaPicker: MPMediaPickerController!, didPickMediaItems mediaItemCollection: MPMediaItemCollection!) {
        for thisItem in mediaItemCollection.items as! [MPMediaItem]{
            
            let itemUrl = thisItem.valueForProperty(MPMediaItemPropertyAssetURL)
                as? NSURL
            
            let itemTitle =
            thisItem.valueForProperty(MPMediaItemPropertyTitle)
                as? String
            
            let itemArtist =
            thisItem.valueForProperty(MPMediaItemPropertyArtist)
                as? String
            
            let itemArtwork =
            thisItem.valueForProperty(MPMediaItemPropertyArtwork)
                as? MPMediaItemArtwork
            
            
            if let url = itemUrl{
                println("Item URL = \(url)")
            }
            
            if let title = itemTitle{
                println("Item Title = \(title)")
            }
            
            if let artist = itemArtist{
                println("Item Artist = \(artist)")
            }
            
            if let artwork = itemArtwork{
                println("Item Artwork = \(artwork)")
            }
            
        }
        
        mediaPicker.dismissViewControllerAnimated(true, completion: nil)
    }
}

