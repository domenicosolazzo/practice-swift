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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        displayMediaPicker()
    }
    
    func displayMediaPicker(){
        
        mediaPicker = MPMediaPickerController(mediaTypes: .any)
        
        if let picker = mediaPicker{
            
            print("Successfully instantiated a media picker")
            picker.delegate = self
            picker.allowsPickingMultipleItems = false
            
            present(picker, animated: true, completion: nil)
            
        } else {
            print("Could not instantiate a media picker")
        }
        
    }
    
    //- MARK: MPMediaPickerControllerDelegate
    func mediaPicker(_ mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
        for thisItem in mediaItemCollection.items {
            
            let itemUrl = thisItem.value(forProperty: MPMediaItemPropertyAssetURL)
                as? URL
            
            let itemTitle =
            thisItem.value(forProperty: MPMediaItemPropertyTitle)
                as? String
            
            let itemArtist =
            thisItem.value(forProperty: MPMediaItemPropertyArtist)
                as? String
            
            let itemArtwork =
            thisItem.value(forProperty: MPMediaItemPropertyArtwork)
                as? MPMediaItemArtwork
            
            
            if let url = itemUrl{
                print("Item URL = \(url)")
            }
            
            if let title = itemTitle{
                print("Item Title = \(title)")
            }
            
            if let artist = itemArtist{
                print("Item Artist = \(artist)")
            }
            
            if let artwork = itemArtwork{
                print("Item Artwork = \(artwork)")
            }
            
        }
        
        mediaPicker.dismiss(animated: true, completion: nil)
    }
}

