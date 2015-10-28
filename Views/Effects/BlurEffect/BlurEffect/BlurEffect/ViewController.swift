//
//  ViewController.swift
//  BlurEffect
//
//  Created by Domenico on 14.04.15.
//  Copyright (c) 2015 Domenico Solazzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        // Create a blur effect. The style is an UIBlurEffectStyle value
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        
        // Add a UIVisualEffectView
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        // Change size and position
        blurEffectView.frame.size = CGSize(width: 200, height: 200)
        blurEffectView.center = view.center
        
        // Add the visual effect view as subview
        view.addSubview(blurEffectView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

