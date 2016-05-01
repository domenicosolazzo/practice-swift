//
//  ViewController.swift
//  AudioExample
//
//  Created by Domenico on 28/04/16.
//  Copyright © 2016 Domenico Solazzo. All rights reserved.
//

import UIKit
import AVFoundation

func += <KeyType, ValueType> (inout left: Dictionary<KeyType, ValueType>, right: Dictionary<KeyType, ValueType>) {
    for (k, v) in right {
        left.updateValue(v, forKey: k)
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    var isRecording:Bool = false
    var isPlaying:Bool = false
    var engine = AVAudioEngine()
    var audioFile:AVAudioFile?
    var player: AVAudioPlayer?
    
    @IBAction func play(sender: UIButton) {
        isPlaying = !isPlaying
        if(isPlaying){
            playButton.setTitle("Playing", forState: UIControlState.Normal)
            
            do {
                player = try AVAudioPlayer(contentsOfURL: getUrl())
                player!.play()
            } catch {
                // couldn't load file :(
            }
        }else{
            playButton.setTitle("Play", forState: UIControlState.Normal)
            player?.stop()
        }
    }
    
    @IBAction func recording(sender: AnyObject) {
        isRecording = !isRecording
        let input = engine.inputNode!
        let bus = 0
        let format = input.inputFormatForBus(bus)
        if(isRecording){
            recordButton.setTitle("Recording", forState: UIControlState.Normal)
            input.installTapOnBus(bus, bufferSize: 4096, format: format) {
                (buffer: AVAudioPCMBuffer!, time: AVAudioTime!) -> Void in
                print("tapping the input")
                print(buffer)
                do{
                    try self.audioFile?.writeFromBuffer(buffer)
                }catch{
                    print("error")
                }
            }
            // Start engine
            do {
                try engine.start()
            } catch {
                assertionFailure("AVAudioEngine start error: \(error)")
            }

        }else{
            input.removeTapOnBus(bus)
            recordButton.setTitle("Record", forState: UIControlState.Normal)
            engine.stop()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Setup AVAudioSession
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayAndRecord)
            
            //let ioBufferDuration = 128.0 / 44100.0
            
            //try AVAudioSession.sharedInstance().setPreferredIOBufferDuration(ioBufferDuration)
            
        } catch {
            assertionFailure("AVAudioSession setup error: \(error)")
        }
        
        // Setup engine and node instances
        assert(engine.inputNode != nil)
        let input = engine.inputNode!
        input.volume = 1
        
        let output = engine.outputNode
        let bus = 0
        let format = input.inputFormatForBus(bus)
        
        self.createAudioFile(format)
        
        
        // Connect nodes
        engine.connect(input, to: output, format: format)
    }

    func createAudioFile(format:AVAudioFormat){
        let settings =
            [AVFormatIDKey: NSNumber(int: Int32(kAudioFormatLinearPCM)),
             AVSampleRateKey: format.sampleRate,
             AVNumberOfChannelsKey: 2,
             AVLinearPCMBitDepthKey : 32,
             AVLinearPCMIsBigEndianKey : false,
             AVLinearPCMIsFloatKey : true,
             AVLinearPCMIsNonInterleaved : false];
        
        
        do{
            self.audioFile = try AVAudioFile(forWriting: getUrl(), settings: settings, commonFormat: AVAudioCommonFormat.PCMFormatFloat32, interleaved: false)
        }catch{
            print("error")
        }
    }
    
    func getUrl() -> NSURL{
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as [String]
        let documentsDirectory = paths[0] as NSString
        let audioFilename = documentsDirectory.stringByAppendingPathComponent("whistle.wav")
        let audioURL = NSURL(fileURLWithPath: audioFilename)
        
        return audioURL
    
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

