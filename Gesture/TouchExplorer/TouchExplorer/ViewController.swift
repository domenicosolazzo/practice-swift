//
//  ViewController.swift
//  TouchExplorer
//
//  Created by Domenico on 01/05/15.
//  Copyright (c) 2015 Domenico. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var messageLabel:UILabel!
    @IBOutlet var tapsLabel:UILabel!
    @IBOutlet var touchesLabel:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    func updateLabelsFromTouches(_ touches:Set<NSObject>!) {
        let touch = touches.first as! UITouch
        let numTaps = touch.tapCount
        let tapsMessage = "\(numTaps) taps detected"
        tapsLabel.text = tapsMessage
        
        let numTouches = touches.count
        let touchMsg = "\(numTouches) touches detected"
        touchesLabel.text = touchMsg
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        messageLabel.text = "Touches Began"
        updateLabelsFromTouches(event?.allTouches)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        messageLabel.text = "Touches Cancelled"
        updateLabelsFromTouches(event?.allTouches)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        messageLabel.text = "Touches Ended"
        updateLabelsFromTouches(event?.allTouches)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        messageLabel.text = "Drag Detected"
        updateLabelsFromTouches(event?.allTouches)
    }


}

