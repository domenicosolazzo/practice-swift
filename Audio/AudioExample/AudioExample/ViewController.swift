//
//  ViewController.swift
//  AudioExample
//
//  Created by Domenico on 28/04/16.
//  Copyright © 2016 Domenico Solazzo. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var engine = AVAudioEngine()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Setup AVAudioSession
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayAndRecord)
            
            let ioBufferDuration = 128.0 / 44100.0
            
            try AVAudioSession.sharedInstance().setPreferredIOBufferDuration(ioBufferDuration)
            
        } catch {
            assertionFailure("AVAudioSession setup error: \(error)")
        }
        
        // Setup engine and node instances
        assert(engine.inputNode != nil)
        let input = engine.inputNode!
        let output = engine.outputNode
        let bus = 0
        let format = input.inputFormatForBus(bus)
        
        input.installTapOnBus(bus, bufferSize: 2048, format: format) {
            (buffer: AVAudioPCMBuffer!, time: AVAudioTime!) -> Void in
            print("tapping the input")
            print(buffer)
        }
        
        // Connect nodes
        engine.connect(input, to: output, format: format)
        
        
        // Start engine
        do {
            try engine.start()
        } catch {
            assertionFailure("AVAudioEngine start error: \(error)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

