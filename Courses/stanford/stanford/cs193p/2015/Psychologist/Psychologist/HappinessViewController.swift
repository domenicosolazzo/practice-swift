//
//  HappinessViewController.swift
//  Happiness
//
//  Created by Domenico on 19.03.15.
//  Copyright (c) 2015 Domenico Solazzo. All rights reserved.
//

import UIKit

class HappinessViewController: UIViewController, FaceViewDataSource {

    @IBOutlet weak var faceView: FaceView!{
        didSet{
            faceView.dataSource = self
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(target:faceView, action:"scale:"))
        }
    }
    
    private struct Constants{
        static let HappinessGestureScale: CGFloat = 4
    }
    @IBAction func changeHappiness(gesture: UIPanGestureRecognizer) {
        switch gesture.state{
        case .Ended: fallthrough
        case .Changed:
            let translation = gesture.translationInView(faceView)
            let happinessChange = -Int(translation.y / Constants.HappinessGestureScale)
            if happinessChange != 0{
                happiness += happinessChange
                gesture.setTranslation(CGPointZero, inView: faceView)
            }
        default: break
        }
        
    }
    var happiness: Int = 50{ // 0 = very sad, 100 = estatic
        didSet{
            happiness = min(max(happiness, 0),100)
            println("happiness: \(happiness)")
            self.updateUI()
            self.title = "\(happiness)"
        }
    }
    func updateUI(){
        // Check if the FaceView is set before using setNeedsDisplay
        faceView?.setNeedsDisplay()
    }
    
    func smilinessForFaceView(sender: FaceView) -> Double? {
            return Double(happiness-50)/50
    }
}
