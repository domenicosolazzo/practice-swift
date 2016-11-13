//
//  ViewController.swift
//  Listening to Keyboard notifications
//
//  Created by Domenico Solazzo on 15/05/15.
//  License MIT
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let center = NotificationCenter.default
        
        center.addObserver(
            self,
            selector: #selector(ViewController.handleKeyboardWillShow(_:)),
            name: NSNotification.Name.UIKeyboardWillShow,
            object: nil
        )
        
        center.addObserver(
            self,
            selector: #selector(ViewController.handleKeyboardWillHide(_:)),
            name: NSNotification.Name.UIKeyboardWillHide,
            object: nil
        )
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
    }
    
    func handleKeyboardWillShow(_ notification:Notification){
        let userInfo = (notification as NSNotification).userInfo
        
        if let info = userInfo{
            /* Get the duration of the animation of the keyboard for when it
            gets displayed on the screen. We will animate our contents using
            the same animation duration */
            let animationDurationObject =
            info[UIKeyboardAnimationDurationUserInfoKey] as! NSValue
            
            let keyboardEndRectObject =
            info[UIKeyboardFrameEndUserInfoKey] as! NSValue
            
            var animationDuration = 0.0
            var keyboardEndRect = CGRect.zero
            
            animationDurationObject.getValue(&animationDuration)
            keyboardEndRectObject.getValue(&keyboardEndRect)
            
            let window = UIApplication.shared.keyWindow
            
            /* Convert the frame from the window's coordinate system to
            our view's coordinate system */
            keyboardEndRect = view.convert(keyboardEndRect, from: window)
            
            /* Find out how much of our view is being covered by the keyboard */
            let intersectionOfKeyboardRectAndWindowRect =
            view.frame.intersection(keyboardEndRect);
            
            
            /* Scroll the scroll view up to show the full contents of our view */
            UIView.animate(withDuration: animationDuration, animations: {[weak self] in
                
                self!.scrollView.contentInset = UIEdgeInsets(top: 0,
                    left: 0,
                    bottom: intersectionOfKeyboardRectAndWindowRect.size.height,
                    right: 0)
                
                self!.scrollView.scrollRectToVisible(self!.textField.frame,
                    animated: false)
                
            })
        }
        
        
    }
    
    func handleKeyboardWillHide(_ notification: Notification){
        let userInfo = (notification as NSNotification).userInfo
        
        if let info = userInfo{
            let animationDurationObject =
            info[UIKeyboardAnimationDurationUserInfoKey]
                as! NSValue
            
            var animationDuration = 0.0;
            
            animationDurationObject.getValue(&animationDuration)
            
            UIView.animate(withDuration: animationDuration, animations: {
                [weak self] in
                self!.scrollView.contentInset = UIEdgeInsets.zero
                })
        }
    }
}

