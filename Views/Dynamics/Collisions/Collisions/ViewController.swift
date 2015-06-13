//
//  ViewController.swift
//  Collisions
//
//  Created by Domenico on 13/06/15.
//  Copyright (c) 2015 Domenico. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var animator: UIDynamicAnimator!
    var gravity: UIGravityBehavior!
    var collision: UICollisionBehavior!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var firstView = UIView(frame: CGRect(x: CGFloat(84), y: CGFloat(42), width: CGFloat(100), height: CGFloat(120)))
        var secondView = UIView(frame: CGRect(x: CGFloat(84), y: CGFloat(100), width: CGFloat(100), height: CGFloat(120)))
            
        animator = UIDynamicAnimator(referenceView: self.view)
        gravity = UIGravityBehavior(items: [firstView, secondView])
        animator.addBehavior(gravity)
        
        collision = UICollisionBehavior(items: [firstView, secondView])
        collision.collisionMode = UICollisionBehaviorMode.Boundaries
        // Set a boundary
        collision.translatesReferenceBoundsIntoBoundary = true
        // Set the delegate
        collision.collisionDelegate = self
        animator.addBehavior(collision)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

