//
//  DropItViewController.swift
//  DropIt
//
//  Created by Domenico on 12.04.15.
//  Copyright (c) 2015 Domenico Solazzo. All rights reserved.
//

import UIKit

class DropItViewController: UIViewController, UIDynamicAnimatorDelegate {

    @IBOutlet weak var gameView: BezierPathsView!
    
    
    
    // Dynamic Animator
    // Do not call this before self.gameView is set
    lazy var animator: UIDynamicAnimator = {
       let lazilyCreatedDynamicAnimator = UIDynamicAnimator(referenceView: self.gameView)
        lazilyCreatedDynamicAnimator.delegate = self
        return lazilyCreatedDynamicAnimator
    }()
    
    var dropsPerRow = 10
    
    var dropSize: CGSize{
        let size = gameView.bounds.size.width / CGFloat(dropsPerRow)
        return CGSize(width: size, height: size)
    }
    
    var dropitBehavior = DropBehavior()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animator.addBehavior(dropitBehavior)
    }
    struct PathNames{
        static let MiddleBarrier = "Middle Barrier"
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let barrierSize = dropSize
        let barrierOrigin = CGPoint(x: gameView.bounds.midX-barrierSize.width/2, y: gameView.bounds.midY-barrierSize.height/2)
        let path = UIBezierPath(ovalInRect: CGRect(origin: barrierOrigin, size: barrierSize))
        dropitBehavior.addBarrier(path, named:PathNames.MiddleBarrier)
        gameView.setPath(path, named: PathNames.MiddleBarrier)
    }
    
    func dynamicAnimatorDidPause(animator: UIDynamicAnimator) {
        removeCompletedRow()
    }
    @IBAction func drop(sender: UITapGestureRecognizer) {
        drop()
    }
    
    func drop(){
        var frame = CGRect(origin: CGPointZero, size: dropSize)
        frame.origin.x = CGFloat.random(dropsPerRow) * dropSize.width
        
        let dropView = UIView(frame:frame)
        dropView.backgroundColor = UIColor.random
        
        dropitBehavior.addDrop(dropView)
    }
    
    func removeCompletedRow(){
        var dropsToRemove = [UIView]()
        var dropFrame = CGRect(x: 0, y:gameView.frame.maxY, width:dropSize.width, height: dropSize.height)
        
        do{
            dropFrame.origin.y -= dropSize.height
            dropFrame.origin.x = 0
            
            var dropsFound = [UIView]()
            var rowIsComplete = true
            
            for _ in 0 ..< dropsPerRow{
                if let hitView = gameView.hitTest(CGPoint(x: dropFrame.midX, y: dropFrame.midY), withEvent: nil){
                    if hitView.superview == gameView{
                        dropsFound.append(hitView)
                    }else{
                        rowIsComplete = false
                    }
                }
        
            }
            if rowIsComplete{
                dropsToRemove += dropsFound
            }
        }while dropsToRemove.count == 0 && dropFrame.origin.y > 0
        for drop in dropsToRemove{
            dropitBehavior.removeDrop(drop)
        }
    }
}

private extension CGFloat {
    // Random float between 0 and max
    static func random(max:Int) -> CGFloat{
        return CGFloat(arc4random() % UInt32(max))
    }
}

private extension UIColor{
    class var random: UIColor{
        switch arc4random() % 5{
        case 0: return UIColor.greenColor()
        case 1: return UIColor.blueColor()
        case 2: return UIColor.orangeColor()
        case 3: return UIColor.redColor()
        case 4: return UIColor.purpleColor()
        default: return UIColor.blackColor()
        }
    }
}



