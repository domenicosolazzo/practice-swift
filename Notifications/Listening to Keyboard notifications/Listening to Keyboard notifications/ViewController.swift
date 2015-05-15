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
}

