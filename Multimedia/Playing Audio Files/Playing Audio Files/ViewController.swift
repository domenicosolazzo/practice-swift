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
        
        let queue = DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.default)
        
        queue.async(execute: {[weak self] in
            let strongSelf = self!
            let mainBundle = Bundle.main
            
            // Location of the audio file
            let filePath = mainBundle.path(forResource: "MySong", ofType: "mp3")
            
            if let path = filePath{
                let fileData = try? Data(contentsOf: URL(fileURLWithPath: path))
                
                var error: NSError?
                do {
                    // Start the audio player
                    strongSelf.audioPlayer = try AVAudioPlayer(data: fileData!)
                } catch let error1 as NSError {
                    error = error1
                    strongSelf.audioPlayer = nil
                } catch {
                    fatalError()
                }
                
                if let player = strongSelf.audioPlayer{
                    // Set the delegate
                    player.delegate = self
                    if player.prepareToPlay() && player.play(){
                        print("Successfully started playing")
                    }else{
                        print("Failed to play")
                    }
                }else{
                    print("Cannot instantiate an audio player")
                }
            }
        
        })
    }
    
    //- MARK: AVAudioPlayerDelegate
    // This delegate method will let us know when the audio player will finish playing
    // the file
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        print("Finished playing....")
    }
}

