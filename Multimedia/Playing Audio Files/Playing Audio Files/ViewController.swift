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

    //- MARK: AVAudioPlayerDelegate
    // This delegate method will let us know when the audio player will finish playing
    // the file
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer!, successfully flag: Bool) {
        println("Finished playing....")
    }
}

