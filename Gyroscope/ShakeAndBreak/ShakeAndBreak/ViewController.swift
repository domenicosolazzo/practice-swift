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
    private var fixed:UIImage!
    private var broken:UIImage!
    private var brokenScreenShowing = false
    private var crashPlayer:AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url =
        NSBundle.mainBundle().URLForResource("glass", withExtension:"wav")
        
        var createError:NSError?
        crashPlayer = AVAudioPlayer(contentsOfURL: url, error: &createError)
        if crashPlayer == nil {
            if let error = createError {
                println("Audio error! \(error.localizedDescription)")
            }
        }
        
        fixed = UIImage(named:"home")
        broken = UIImage(named:"homebroken")
        imageView!.image = fixed
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

