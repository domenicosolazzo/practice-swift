//
//  ViewController.swift
//  Playing Audio Files
//
//  Created by Domenico on 23/05/15.
//  License MIT
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {
    var audioPlayer: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        
        dispatch_async(queue, {[weak self] in
            var strongSelf = self!
            let mainBundle = NSBundle.mainBundle()
            
            // Location of the audio file
            let filePath = mainBundle.pathForResource("MySong", ofType: "mp3")
            
            if let path = filePath{
                let fileData = NSData(contentsOfFile: path)
                
                var error: NSError?
                // Start the audio player
                strongSelf.audioPlayer = AVAudioPlayer(data: fileData, error: &error)
                
                if let player = strongSelf.audioPlayer{
                    // Set the delegate
                    player.delegate = self
                    if player.prepareToPlay() && player.play(){
                        println("Successfully started playing")
                    }else{
                        println("Failed to play")
                    }
                }else{
                    println("Cannot instantiate an audio player")
                }
            }
        
        })
    }
    
    //- MARK: AVAudioPlayerDelegate
    // This delegate method will let us know when the audio player will finish playing
    // the file
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer!, successfully flag: Bool) {
        println("Finished playing....")
    }
}

