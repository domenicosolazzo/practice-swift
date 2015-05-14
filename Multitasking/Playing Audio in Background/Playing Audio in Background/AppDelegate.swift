//
//  AppDelegate.swift
//  Playing Audio in Background
//
//  Created by Domenico Solazzo on 14/05/15.
//  License MIT
//

import UIKit
import AVFoundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,AVAudioPlayerDelegate {

    var window: UIWindow?
    var audioPlayer: AVAudioPlayer?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        
        let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        dispatch_async(queue, {[weak self] in
            var strongSelf = self!
            var audioSessionError: NSError?
            // Shared instance of AVAudioSession
            let audioSession = AVAudioSession.sharedInstance()
            
            // Adding notification when the audio session is interrupted
            NSNotificationCenter.defaultCenter().addObserver(
                strongSelf,
                selector: "handleInterruption:",
                name: AVAudioSessionInterruptionNotification,
                object: nil)
            
            audioSession.setActive(true, error: nil)
            
            if audioSession.setCategory(AVAudioSessionCategoryPlayback,
                error: &audioSessionError){
                    println("Successfully set the audio session")
            } else {
                println("Could not set the audio session")
            }
            
            // File path for the audio file
            let filePath = NSBundle.mainBundle().pathForResource("MySong", ofType: "mp3")
            // File data
            let fileData = NSData(contentsOfFile: filePath!, options: NSDataReadingOptions.DataReadingMappedIfSafe, error: nil)
            
            var error:NSError?
            
            /* Start the audio player */
            self!.audioPlayer = AVAudioPlayer(data: fileData, error: &error)
            
            /* Did we get an instance of AVAudioPlayer? */
            if let theAudioPlayer = self!.audioPlayer{
                theAudioPlayer.delegate = self;
                if theAudioPlayer.prepareToPlay() &&
                    theAudioPlayer.play(){
                        println("Successfully started playing")
                } else {
                    println("Failed to play")
                }
            } else {
                println("Error instantiating a new audio player....Help!")
            }
            
        })
        return true
    }
    
    func handleInterruption(notification: NSNotification){
        /* Audio Session is interrupted. The player will be paused here */
        
        let interruptionTypeAsObject =
        notification.userInfo![AVAudioSessionInterruptionTypeKey] as! NSNumber
        
        let interruptionType = AVAudioSessionInterruptionType(rawValue:
            interruptionTypeAsObject.unsignedLongValue)
        
        if let type = interruptionType{
            if type == .Ended{
                
                /* resume the audio if needed */
                
            }
        }
        
    }
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer!,
        successfully flag: Bool){
            
            println("Finished playing the song")
            
            /* The flag parameter tells us if the playback was successfully
            finished or not */
            if player == audioPlayer{
                audioPlayer = nil
            }
            
    }
    

}

