//
//  ViewController.swift
//  Listening to Keyboard notifications
//
//  Created by Domenico Solazzo on 15/05/15.
//  License MIT
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let center = NSNotificationCenter.defaultCenter()
        
        center.addObserver(
            self,
            selector: "handleKeyboardWillShow:",
            name: UIKeyboardWillShowNotification,
            object: nil
        )
        
        center.addObserver(
            self,
            selector: "handleKeyboardWillHide:",
            name: UIKeyboardWillHideNotification,
            object: nil
        )
    }
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func handleKeyboardWillShow(notification:NSNotification){
        var userInfo = notification.userInfo
        
        if let info = userInfo{
            /* Get the duration of the animation of the keyboard for when it
            gets displayed on the screen. We will animate our contents using
            the same animation duration */
            let animationDurationObject =
            info[UIKeyboardAnimationDurationUserInfoKey] as! NSValue
            
            let keyboardEndRectObject =
            info[UIKeyboardFrameEndUserInfoKey] as! NSValue
            
            var animationDuration = 0.0
            var keyboardEndRect = CGRectZero
            
            animationDurationObject.getValue(&animationDuration)
            keyboardEndRectObject.getValue(&keyboardEndRect)
            
            let window = UIApplication.sharedApplication().keyWindow
            
            /* Convert the frame from the window's coordinate system to
            our view's coordinate system */
            keyboardEndRect = view.convertRect(keyboardEndRect, fromView: window)
            
            /* Find out how much of our view is being covered by the keyboard */
            let intersectionOfKeyboardRectAndWindowRect =
            CGRectIntersection(view.frame, keyboardEndRect);
            
            
            /* Scroll the scroll view up to show the full contents of our view */
            UIView.animateWithDuration(animationDuration, animations: {[weak self] in
                
                self!.scrollView.contentInset = UIEdgeInsets(top: 0,
                    left: 0,
                    bottom: intersectionOfKeyboardRectAndWindowRect.size.height,
                    right: 0)
                
                self!.scrollView.scrollRectToVisible(self!.textField.frame,
                    animated: false)
                
            })
        }
        
        func handleKeyboardWillHide(notification: NSNotification){
            let userInfo = notification.userInfo
            
            if let info = userInfo{
                let animationDurationObject =
                info[UIKeyboardAnimationDurationUserInfoKey]
                    as! NSValue
                
                var animationDuration = 0.0;
                
                animationDurationObject.getValue(&animationDuration)
                
                UIView.animateWithDuration(animationDuration, animations: {
                    [weak self] in
                    self!.scrollView.contentInset = UIEdgeInsetsZero
                    })
            }
        }
    }
}

