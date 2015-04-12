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
    
    override init(){
        super.init()
        addChildBehavior(gravity)
        addChildBehavior(collider)
    }
    
    func addDrop(drop: UIView){
        dynamicAnimator?.referenceView?.addSubview(drop)
        gravity.addItem(drop)
        collider.addItem(drop)
    }
    
    func removeDrop(drop: UIView){
        gravity.removeItem(drop)
        collider.removeItem(drop)
        drop.removeFromSuperview()
    }
}
