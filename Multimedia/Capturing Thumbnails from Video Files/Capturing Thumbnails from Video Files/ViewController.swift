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
    
    func videoHasFinishedPlaying(notification: NSNotification){
        
        println("Video finished playing")
        
        /* Find out what the reason was for the player to stop */
        let reason =
        notification.userInfo![MPMoviePlayerPlaybackDidFinishReasonUserInfoKey]
            as! NSNumber?
        
        if let theReason = reason{
            
            let reasonValue = MPMovieFinishReason(rawValue: theReason.integerValue)
            
            switch reasonValue!{
            case .PlaybackEnded:
                /* The movie ended normally */
                println("Playback Ended")
            case .PlaybackError:
                /* An error happened and the movie ended */
                println("Error happened")
            case .UserExited:
                /* The user exited the player */
                println("User exited")
            default:
                println("Another event happened")
            }
            
            println("Finish Reason = \(theReason)")
            stopPlayingVideo()
        }
        
    }

    func videoThumbnailIsAvailable(notification: NSNotification){
        
        if let player = moviePlayer{
            println("Thumbnail is available")
            
            /* Now get the thumbnail out of the user info dictionary */
            let thumbnail =
            notification.userInfo![MPMoviePlayerThumbnailImageKey] as? UIImage
            
            if let image = thumbnail{
                
                /* We got the thumbnail image. You can now use it here */
                println("Thumbnail image = \(image)")
                
            }
        }
        
    }
    
    func stopPlayingVideo() {
        
        if let player = moviePlayer{
            NSNotificationCenter.defaultCenter().removeObserver(self)
            player.stop()
            player.view.removeFromSuperview()
        }
        
    }
}

