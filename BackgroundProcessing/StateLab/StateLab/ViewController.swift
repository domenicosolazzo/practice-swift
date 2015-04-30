//
//  ViewController.swift
//  StateLab
//
//  Created by Domenico on 30/04/15.
//  Copyright (c) 2015 Domenico. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var label:UILabel!
    private var animate:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let bounds = view.bounds
        let labelFrame:CGRect = CGRectMake(bounds.origin.x,
            CGRectGetMidY(bounds) - 50, bounds.size.width, 100)
        label = UILabel(frame:labelFrame)
        label.font = UIFont(name:"Helvetica", size:70)
        label.text = "Bazinga!"
        label.textAlignment = NSTextAlignment.Center
        label.backgroundColor = UIColor.clearColor()
        view.addSubview(label)
        
        self.rotateLabelDown()
        
        // Notification
        let center = NSNotificationCenter.defaultCenter()
        center.addObserver(self, selector: "applicationWillResignActive",
            name: UIApplicationWillResignActiveNotification, object: nil)
        center.addObserver(self, selector: "applicationDidBecomeActive",
            name: UIApplicationDidBecomeActiveNotification, object: nil)
    }
    
    func applicationWillResignActive() {
        println("VC: \(__FUNCTION__)")
        animate = false
    }
    
    func applicationDidBecomeActive() {
        println("VC: \(__FUNCTION__)")
        animate = true
        rotateLabelDown()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func rotateLabelDown() {
        UIView.animateWithDuration(0.5, animations: {
            self.label.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
            },
            completion: {(bool) -> Void in
                self.rotateLabelUp()
        })
    }
    
    func rotateLabelUp() {
        UIView.animateWithDuration(0.5, animations: {
            self.label.transform = CGAffineTransformMakeRotation(0)
            },
            completion: {(bool) -> Void in
                if self.animate{
                    self.rotateLabelDown()
                }
                
        })
    }


}

