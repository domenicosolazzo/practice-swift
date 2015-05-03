//
//  DropBehavior.swift
//  DropIt
//
//  Created by Domenico on 12.04.15.
//  Copyright (c) 2015 Domenico Solazzo. All rights reserved.
//

import UIKit

class DropBehavior: UIDynamicBehavior {
   
    // Gravity Behaviour
    var gravity = UIGravityBehavior()
    
    // Collider Behaviour
    lazy var collider: UICollisionBehavior = {
        let lazilyCreatedCollider = UICollisionBehavior()
        lazilyCreatedCollider.translatesReferenceBoundsIntoBoundary = true;
        return lazilyCreatedCollider
        }()
    
    lazy var dropBehavior:UIDynamicItemBehavior = {
        let lazilyCreatedDropBehavior = UIDynamicItemBehavior()
        lazilyCreatedDropBehavior.allowsRotation = true
        // Elasticity
        lazilyCreatedDropBehavior.elasticity = 0.75
        return lazilyCreatedDropBehavior
    }()
    
    override init(){
        super.init()
        addChildBehavior(gravity)
        addChildBehavior(collider)
        addChildBehavior(dropBehavior)
    }
    
    func addBarrier(path: UIBezierPath, named name:String){
        collider.removeBoundaryWithIdentifier(name)
        collider.addBoundaryWithIdentifier(name, forPath: path)
    }
    func addDrop(drop: UIView){
        dynamicAnimator?.referenceView?.addSubview(drop)
        gravity.addItem(drop)
        collider.addItem(drop)
        dropBehavior.addItem(drop)
    }
    
    func removeDrop(drop: UIView){
        gravity.removeItem(drop)
        collider.removeItem(drop)
        dropBehavior.removeItem(drop)
        drop.removeFromSuperview()
    }
}
