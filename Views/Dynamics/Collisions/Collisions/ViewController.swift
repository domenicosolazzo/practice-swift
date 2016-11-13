//
//  ViewController.swift
//  Collisions
//
//  Created by Domenico on 13/06/15.
//  Copyright (c) 2015 Domenico. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollisionBehaviorDelegate {

    var animator: UIDynamicAnimator!
    var gravity: UIGravityBehavior!
    var collision: UICollisionBehavior!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let firstView = UIView(frame: CGRect(x: CGFloat(84), y: CGFloat(42), width: CGFloat(100), height: CGFloat(120)))
        firstView.backgroundColor = UIColor.red
        let secondView = UIView(frame: CGRect(x: CGFloat(50), y: CGFloat(100), width: CGFloat(100), height: CGFloat(120)))
        secondView.backgroundColor = UIColor.blue
        self.view.addSubview(firstView)
        self.view.addSubview(secondView)
            
        animator = UIDynamicAnimator(referenceView: self.view)
        gravity = UIGravityBehavior(items: [firstView, secondView])
        animator.addBehavior(gravity)
        
        collision = UICollisionBehavior(items: [firstView, secondView])
        collision.collisionMode = UICollisionBehaviorMode.boundaries
        // Set a boundary
        collision.translatesReferenceBoundsIntoBoundary = true
        // Set the delegate
        collision.collisionDelegate = self
        animator.addBehavior(collision)
        
        
    }
    
    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item1: UIDynamicItem, with item2: UIDynamicItem, at p: CGPoint) {
        print("Item1: \(item1)")
        print("Item2: \(item2)")
    }
    
    func collisionBehavior(_ behavior: UICollisionBehavior, endedContactFor item1: UIDynamicItem, with item2: UIDynamicItem) {
        print("Collision ended")
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

