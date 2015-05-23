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

}

