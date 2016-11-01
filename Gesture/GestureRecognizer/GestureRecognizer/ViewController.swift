//
//  ViewController.swift
//  GestureRecognizer
//
//  Created by Domenico on 01/05/15.
//  Copyright (c) 2015 Domenico. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var label:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        for  touchCount in (1 ..< 5) {
            let vertical = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.reportVerticalSwipe(_:)))
            vertical.direction = .up
            vertical.numberOfTouchesRequired = touchCount
            view.addGestureRecognizer(vertical)
            
            let horizontal = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.reportHorizontalSwipe(_:)))
            horizontal.direction = .left 
            horizontal.numberOfTouchesRequired = touchCount
            view.addGestureRecognizer(horizontal)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func reportHorizontalSwipe(_ recognizer:UIGestureRecognizer) {
        label.text = "Horizontal swipe detected"
        let count = descriptionForTouchCount(recognizer.numberOfTouches)
        label.text = "\(count) Horizontal swipe detected"
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(2 * NSEC_PER_SEC)) / Double(NSEC_PER_SEC),
            execute: { self.label.text = "" })
    }
    
    func reportVerticalSwipe(_ recognizer:UIGestureRecognizer) {
        label.text = "Vertical swipe detected"
        let count = descriptionForTouchCount(recognizer.numberOfTouches)
        label.text = "\(count) Vertical swipe detected"
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(2 * NSEC_PER_SEC)) / Double(NSEC_PER_SEC),
            execute: { self.label.text = "" })
    }
    
    func descriptionForTouchCount(_ touchCount:Int) -> String {
        switch touchCount {
        case 1:
            return "Single"
        case 2:
            return "Double"
        case 3:
            return "Triple"
        case 4:
            return "Quadruple"
        case 5:
            return "Quintuple"
        default:
            return ""
        }
    }
    
}

