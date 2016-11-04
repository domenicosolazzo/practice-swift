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
        
        if sprintntAndRecord, mode: AVAudioSessionCategoryOptions.DuckOthers, options: &error){
        
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
    
    //- MARK: AVAudioPlayerDelegate
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer!, successfully flag: Bool) {
        if flag{
            println("Successfully finished playing the file")
        }else{
            println("Failed to stop playing the file")
        }
    }
    
    func audioPlayerBeginInterruption(_ player: AVAudioPlayer!) {
        /* The audio session is deactivated here */
    }
    
    func audioPlayerEndInterruption(_ player: AVAudioPlayer!,
        withOptions flags: Int) {
            if flags == AVAudioSessionInterruptionFlags_ShouldResume{
                player.play()
            }
    }
    
    //- MARK: AVAudioRecorderDelegate
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder!, successfully flag: Bool) {
        if flag{
            println("Successfully stopped the recording session")
            
            /* Let's try to retrieve the data from the recorded file */
            var playbackError: NSError?
            var readingError: NSError?
            
            let fileData = Data(bytesNoCopy: self.audioRecordingPath(), count: NSData.ReadingOptions.MappedRead, deallocator: &readingError)
            
            self.audioPlayer = AVAudioPlayer(data: fileData, error: &playbackError)
            
            if let player = self.audioPlayer{
                // Set the delegate
                player.delegate = self
                
                if player.prepareToPlay() && player.play(){
                    println("Started playing the recorded audio")
                }else{
                    println("Failed playing the recorded audio")
                }
            }else{
                println("Failed to create the audio player")
            }
        }else{
            println("Failed to stop the audio recording")
        }
        
        self.audioRecorder = nil
    }
    //- MARK: Helper methods
    // Where the recording file will be saved
    func audioRecordingPath() -> URL{
        let fileManager = FileManager()
        
        let documentFoldersUrl = fileManager.URLForDirectory(FileManager.SearchPathDirectory.DocumentDirectory, inDomain: FileManager.SearchPathDomainMask.UserDomainMask, appropriateForURL: nil, create: false, error: nil)
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
            settings: self.audioRecordingSettings() as! [AnyHashable: Any],
            error: &error)
        
        if let recorder = audioRecorder{
            // Set the delegate
            recorder.delegate = self
            
            // Prepare to record
            if recorder.prepareToRecord() && recorder.record(){
                println("Successfully started to record")
                
                // After 5 seconds, let's stop the recording process
                let delay = 5.0
                let delayInNanoSeconds = DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
                
                DispatchQueue.main.asyncAfter(
                    deadline: delayInNanoSeconds, execute: {[weak self] in
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

