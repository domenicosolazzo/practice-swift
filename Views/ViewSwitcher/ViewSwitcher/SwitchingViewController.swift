//
//  SwitchingViewController.swift
//  ViewSwitcher
//
//  Created by Domenico on 19.04.15.
//  Copyright (c) 2015 Domenico Solazzo. All rights reserved.
//

import UIKit

class SwitchingViewController: UIViewController {

    fileprivate var blueViewController: BlueViewController!
    fileprivate var yellowViewController: YellowViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Create an instance of BlueViewController
        blueViewController = storyboard?.instantiateViewController(withIdentifier: "Blue") as! BlueViewController
        blueViewController.view.frame = view.frame
        /// Switching the current view using the helper method
        switchViewController(from: nil, to: blueViewController)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Disponse any resources
        
        if blueViewController != nil
            && blueViewController!.view.superview == nil {
                blueViewController = nil
        }
        if yellowViewController != nil
            && yellowViewController!.view.superview == nil {
                yellowViewController = nil
        }
    }
    
    @IBAction func switchViews(_ sender: UIBarButtonItem){
        // Create the new view controller, if required
        if yellowViewController?.view.superview == nil{
            if yellowViewController == nil{
                yellowViewController = storyboard?.instantiateViewController(withIdentifier: "Yellow")
                                as! YellowViewController
            }
        }else if blueViewController?.view.superview == nil{
            if blueViewController == nil{
                blueViewController = storyboard?.instantiateViewController(withIdentifier: "Blue")
                                as! BlueViewController
            }
        }
        
        // Adding the animation
        UIView.beginAnimations("View Flip", context: nil)
        UIView.setAnimationDuration(0.4)
        UIView.setAnimationCurve(UIViewAnimationCurve.easeInOut)
        
        // Switch view controllers
        if blueViewController != nil &&
            blueViewController!.view.superview != nil{
                UIView.setAnimationTransition(UIViewAnimationTransition.flipFromRight, for: view, cache: true)
                yellowViewController.view.frame = view.frame
                switchViewController(from: blueViewController, to: yellowViewController)
        }else{
            UIView.setAnimationTransition(UIViewAnimationTransition.flipFromLeft, for: view, cache: true)
            blueViewController.view.frame = view.frame
            switchViewController(from: yellowViewController, to: blueViewController)
        }
        UIView.commitAnimations()
    }
    
    fileprivate func switchViewController(from fromVC:UIViewController?,
        to toVC:UIViewController?) {
            if fromVC != nil {
                
                fromVC!.willMove(toParentViewController: nil)
                fromVC!.view.removeFromSuperview()
                fromVC!.removeFromParentViewController()
            }
            
            if toVC != nil {
                /// It makes the incoming view controller a child of the switching view controller
                self.addChildViewController(toVC!)
                /// The child view controller’s view is added
                self.view.insertSubview(toVC!.view, at: 0)
                /// We notify the incoming view controller that it has been added as 
                /// the child of another controller
                toVC!.didMove(toParentViewController: self)
            }
    }

}
