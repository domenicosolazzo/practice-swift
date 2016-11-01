//
//  ViewController.swift
//  Detecting Shakes on an iOS Device
//
//  Created by Domenico on 21/05/15.
//  License MIT
//

import UIKit
import CoreMotion

class ViewController: UIViewController {

    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake{
            let controller = UIAlertController(title: "Shake",
                message: "The device is shaken",
                preferredStyle: .alert)
            
            controller.addAction(UIAlertAction(title: "OK",
                style: .default,
                handler: nil))
            
            present(controller, animated: true, completion: nil)
            
        }
    }
}

