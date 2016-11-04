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
    var moviePlayer: MPMoviePlayerController?
    var playButton: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playButton = UIButton(type: .system) as? UIButton
        
        if let button = playButton{
            
            /* Add our button to the screen. Pressing this button
            will start the video playback */
            button.frame = CGRect(x: 0, y: 0, width: 70, height: 37)
            button.center = view.center
            
            button.autoresizingMask =
                [.flexibleTopMargin, .flexibleLeftMargin, .flexibleBottomMargin, .flexibleRightMargin]
            
            button.addTarget(self,
                action: #selector(ViewController.startPlayingVideo),
                for: .touchUpInside)
            
            button.setTitle("Play", for: UIControlState())
            
            view.addSubview(button)
            
        }
    }
    
    //- MARK: Video player
    func stopPlayingVideo() {
        
        if let player = moviePlayer{
            NotificationCenter.default.removeObserver(self)
            player.stop()
            player.view.removeFromSuperview()
        }
        
    }
    
    func videoHasFinishedPlaying(_ notification: Notification){
        
        print("Video finished playing")
        
        /* Find out what the reason was for the player to stop */
        let reason =
        (notification as NSNotification).userInfo![MPMoviePlayerPlaybackDidFinishReasonUserInfoKey]
            as! NSNumber?
        
        if let theReason = reason{
            
            let reasonValue = MPMovieFinishReason(rawValue: theReason.intValue)
            
            switch reasonValue!{
            case .playbackEnded:
                /* The movie ended normally */
                print("Playback Ended")
            case .playbackError:
                /* An error happened and the movie ended */
                print("Error happened")
            case .userExited:
                /* The user exited the player */
                print("User exited")
            default:
                print("Another event happened")
            }
            
            print("Finish Reason = \(theReason)")
            stopPlayingVideo()
        }
        
    }
    
    func videoFilePath() -> URL?{
        /* First let's construct the URL of the file in our application bundle
        that needs to get played by the movie player */
        let mainBundle = Bundle.main
        
        let url = mainBundle.url(forResource: "Sample", withExtension: "m4v")
        return url
    }
    
    func videoStarted(_ notification:Notification){
        print("Started...")
        print("User info: \((notification as NSNotification).userInfo!)")
    }
    
    func startPlayingVideo(){
        
        let url = self.videoFilePath()
        
        /* If we have already created a movie player before,
        let's try to stop it */
        if moviePlayer != nil{
            stopPlayingVideo()
        }
        
        /* Now create a new movie player using the URL */
        moviePlayer = MPMoviePlayerController(contentURL: url)
        
        if let player = moviePlayer{
            
            /* Listen for the notification that the movie player sends us
            whenever it finishes playing */
            NotificationCenter.default.addObserver(self,
                selector: #selector(ViewController.videoHasFinishedPlaying(_:)),
                name: NSNotification.Name.MPMoviePlayerPlaybackDidFinish,
                object: nil)
            
            NotificationCenter.default.addObserver(self, selector: #selector(ViewController.videoStarted(_:)), name: NSNotification.Name.MPMoviePlayerNowPlayingMovieDidChange, object: nil)
            
            print("Successfully instantiated the movie player")
            
            /* Scale the movie player to fit the aspect ratio */
            player.scalingMode = .aspectFit
            
            view.addSubview(player.view)
            
            player.setFullscreen(true, animated: false)
            
            /* Let's start playing the video in full screen mode */
            player.prepareToPlay()
            
            player.play()
            
        } else {
            print("Failed to instantiate the movie player")
        }
        
    }
}

