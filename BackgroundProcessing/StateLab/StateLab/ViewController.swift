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
    private var smiley:UIImage!
    private var smileyView:UIImageView!
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
        
        // smiley.png is 84 x 84
        let smileyFrame = CGRectMake(CGRectGetMidX(bounds) - 42,
            CGRectGetMidY(bounds)/2 - 42, 84, 84)
        
        smileyView = UIImageView(frame:smileyFrame)
        smileyView.contentMode = UIViewContentMode.Center
        let smileyPath =
        NSBundle.mainBundle().pathForResource("smiley", ofType: "png")!
        smiley = UIImage(contentsOfFile: smileyPath)
        smileyView.image = smiley
        view.addSubview(smileyView)
        
        view.addSubview(label)
        
        // Notification
        let center = NSNotificationCenter.defaultCenter()
        center.addObserver(self, selector: "applicationWillResignActive",
            name: UIApplicationWillResignActiveNotification, object: nil)
        center.addObserver(self, selector: "applicationDidBecomeActive",
            name: UIApplicationDidBecomeActiveNotification, object: nil)
        center.addObserver(self, selector: "applicationDidEnterBackground",
            name: UIApplicationDidEnterBackgroundNotification, object: nil)
        center.addObserver(self, selector: "applicationWillEnterForeground",
            name: UIApplicationWillEnterForegroundNotification, object: nil)
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
    
    func applicationDidEnterBackground() {
        println("VC: \(__FUNCTION__)")
        self.smiley = nil;
        self.smileyView.image = nil;
    }
    
    func applicationWillEnterForeground() {
        println("VC: \(__FUNCTION__)")
        let smileyPath =
        NSBundle.mainBundle().pathForResource("smiley", ofType:"png")!
        smiley = UIImage(contentsOfFile: smileyPath)
        smileyView.image = smiley
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

