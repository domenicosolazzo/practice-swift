//
//  ViewController.swift
//  PinchMe
//
//  Created by Domenico on 01/05/15.
//  Copyright (c) 2015 Domenico. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIGestureRecognizerDelegate {

    private var imageView:UIImageView!
    private var scale:CGFloat = 1
    private var previousScale:CGFloat = 1
    private var rotation:CGFloat = 0
    private var previousRotation:CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

