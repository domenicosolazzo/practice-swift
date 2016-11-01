//
//  ViewController.swift
//  ShakeAndBreak
//
//  Created by Domenico on 02/05/15.
//  Copyright (c) 2015 Domenico. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet var imageView:UIImageView?
    fileprivate var fixed:UIImage!
    fileprivate var broken:UIImage!
    fileprivate var brokenScreenShowing = false
    fileprivate var crashPlayer:AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url =
        Bundle.main.url(forResource: "glass", withExtension:"wav")
        
        do{
            crashPlayer = try AVAudioPlayer(contentsOf: url!)
        }catch{
            print("Audio error! \(error.localizedDescription)")
        }
        
        fixed = UIImage(named:"home")
        broken = UIImage(named:"homebroken")
        imageView!.image = fixed
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        imageView!.image = fixed
        brokenScreenShowing = false
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if !brokenScreenShowing && motion == .motionShake {
            imageView!.image = broken;
            crashPlayer.play()
            brokenScreenShowing = true;
        }
    }


}
