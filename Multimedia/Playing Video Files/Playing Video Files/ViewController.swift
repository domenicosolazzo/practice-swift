//
//  ViewController.swift
//  Playing Video Files
//
//  Created by Domenico on 23/05/15.
//  License MIT
//

import UIKit
import MediaPlayer

class ViewController: UIViewController {
    var moviePlayer = MPMoviePlayerController?()
    var playerButton = UIButton?()
    
    //- MARK: Video player
    func stopPlayingVideo() {
        
        if let player = moviePlayer{
            NSNotificationCenter.defaultCenter().removeObserver(self)
            player.stop()
            player.view.removeFromSuperview()
        }
        
    }
}

