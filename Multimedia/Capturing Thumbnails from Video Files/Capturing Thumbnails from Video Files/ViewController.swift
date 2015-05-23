//
//  ViewController.swift
//  Capturing Thumbnails from Video Files
//
//  Created by Domenico on 23/05/15.
//  License MIT
//

import UIKit
import MediaPlayer

class ViewController: UIViewController {
    var moviePlayer: MPMoviePlayerController?
    var playButton: UIButton?
    
    func stopPlayingVideo() {
        
        if let player = moviePlayer{
            NSNotificationCenter.defaultCenter().removeObserver(self)
            player.stop()
            player.view.removeFromSuperview()
        }
        
    }
}

