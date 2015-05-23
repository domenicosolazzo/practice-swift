//
//  ViewController.swift
//  Recording Audio Files
//
//  Created by Domenico on 23/05/15.
//  License MIT
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate,
                    AVAudioRecorderDelegate{
    var audioRecorder: AVAudioRecorder?
    var audioPlayer: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var error: NSError?
        
        let session = AVAudioSession.sharedInstance()
        
        if session.setCategory(AVAudioSessionCategoryPlayAndRecord, withOptions: AVAudioSessionCategoryOptions.DuckOthers, error: &error){
        
            if session.setActive(true, error: nil){
                println("Successfully activated the audio session")
                
                session.requestRecordPermission{[weak self](allowed: Bool) in
                    
                    if allowed{
                        self!.startRecordingAudio()
                    } else {
                        println("We don't have permission to record audio");
                    }
                    
                }
            } else {
                println("Could not activate the audio session")
            }
        }else{
            if let theError = error{
                println("An error occurred in setting the audio " +
                    "session category. Error = \(theError)")
            }
        }
    }
    
    //- MARK: Helper methods
    // Where the recording file will be saved
    func audioRecordingPath() -> NSURL{
        let fileManager = NSFileManager()
        
        let documentFoldersUrl = fileManager.URLForDirectory(NSSearchPathDirectory.DocumentDirectory, inDomain: NSSearchPathDomainMask.UserDomainMask, appropriateForURL: nil, create: false, error: nil)
        return documentFoldersUrl!.URLByAppendingPathComponent("Recording.m4a")
    }
    
    // Audio Recorder settings
    func audioRecordingSettings() -> NSDictionary{
        
        /* Let's prepare the audio recorder options in the dictionary.
        Later we will use this dictionary to instantiate an audio
        recorder of type AVAudioRecorder */
        
        return [
            AVFormatIDKey : kAudioFormatMPEG4AAC as NSNumber,
            AVSampleRateKey : 16000.0 as NSNumber,
            AVNumberOfChannelsKey : 1 as NSNumber,
            AVEncoderAudioQualityKey : AVAudioQuality.Low.rawValue as NSNumber
        ]
        
    }
    
    func startRecordingAudio(){
        var error: NSError?
        
        // File recording path
        let audioRecordingURL = self.audioRecordingPath()
        
        audioRecorder = AVAudioRecorder(
            URL: audioRecordingURL,
            settings: self.audioRecordingSettings() as [NSObject : AnyObject],
            error: &error)
        
        if let recorder = audioRecorder{
            // Set the delegate
            recorder.delegate = self
            
            // Prepare to record
            if recorder.prepareToRecord() && recorder.record(){
                println("Successfully started to record")
                
                // After 5 seconds, let's stop the recording process
                let delay = 5.0
                let delayInNanoSeconds = dispatch_time(DISPATCH_TIME_NOW,
                    Int64(delay * Double(NSEC_PER_SEC)))
                
                dispatch_after(
                    delayInNanoSeconds,
                    dispatch_get_main_queue(), {[weak self] in
                        self!.audioRecorder!.stop()
                })
            }else{
                println("Failed to record...")
                audioRecorder = nil
            }
        }else{
            println("Error creating a new instance of the audio recorder")
        }
    }

}

