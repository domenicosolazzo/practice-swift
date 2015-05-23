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
    
    //- MARK: Helper methods
    // Where the recording file will be saved
    func audioRecordingPath() -> NSURL{
        let fileManager = NSFileManager()
        
        let documentFoldersUrl = fileManager.URLForDirectory(NSSearchPathDirectory.DocumentDirectory, inDomain: NSSearchPathDomainMask.UserDomainMask, appropriateForURL: nil, create: false, error: nil)
        return documentFoldersUrl!.URLByAppendingPathComponent("Recording.m4a")
    }

}

