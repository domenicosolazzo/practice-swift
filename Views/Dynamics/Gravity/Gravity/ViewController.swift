//
//  ViewController.swift
//  Gravity
//
//  Created by Domenico on 13/06/15.
//  Copyright (c) 2015 Domenico. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var dynamicAnimator = UIDynamicAnimator(referenceView: self.view)
        var gravityBehaviour = UIGravityBehavior()
        gravityBehaviour.setAngle(CGFloat(30), magnitude: CGFloat(2))
        
        dynamicAnimator.addBehavior(gravityBehaviour)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

