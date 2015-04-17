//
//  ViewController.swift
//  Animation-SpringingView
//
//  Created by Domenico on 16.04.15.
//  License: MIT
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var v = UIView(frame: CGRectMake(0, 0, 100, 100))
        v.backgroundColor = UIColor.blueColor()
        self.view.addSubview(v)
        
        UIView.animateWithDuration(0.8,
            delay: 0,
            usingSpringWithDamping: 0.7,
            initialSpringVelocity: 20,
            options: nil,
            animations: {
                v.center.y += 100
            },
            completion:nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

