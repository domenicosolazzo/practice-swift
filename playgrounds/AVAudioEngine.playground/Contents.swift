import UIKit
import AVFoundation
import PlaygroundSupport

// Keep playground running
import XCPlayground

PlaygroundPage.current.needsIndefiniteExecution = true

// Setup engine and node instances
var engine = AVAudioEngine()
var delay = AVAudioUnitDelay()
var reverb = AVAudioUnitReverb()
var mixer = engine.mainMixerNode
var input = engine.inputNode
var output = engine.outputNode
var format = input!.inputFormat(forBus: 0)
var error:NSError?

// Attach FX nodes to engine
engine.attach(delay)
engine.attach(reverb)

// Connect nodes
engine.connect(input!, to: delay, format: format)
engine.connect(delay, to: reverb, format: format)
engine.connect(reverb, to: output, format: format)

// Start engine
//engine.startAndReturnError(&error)
do {
    try engine.start()
}
catch {
    print("oh no!")
}

// Change FX parameters
delay.delayTime = 1.5
delay.feedback = 20

reverb.loadFactoryPreset(.mediumChamber)
reverb.wetDryMix = 50
