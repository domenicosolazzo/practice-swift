//
//  ViewController.swift
//  Gravity
//
//  Created by Domenico on 13/06/15.
//  Copyright (c) 2015 Domenico. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var dynamicAnimator: UIDynamicAnimator!
    var gravityBehaviour: UIGravityBehavior!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myView = UIView(frame: CGRect(x: 84, y: 42, width: 100, height: 120))
        myView.backgroundColor = UIColor.blue
        self.view.addSubview(myView)
        
        
        dynamicAnimator = UIDynamicAnimator(referenceView: self.view)
        gravityBehaviour = UIGravityBehavior(items: [myView])
      
        dynamicAnimator.addBehavior(gravityBehaviour)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

