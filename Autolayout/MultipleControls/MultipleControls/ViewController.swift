//
//  ViewController.swift
//  MultipleControls
//
//  Created by Domenico on 18.04.15.
//  Copyright (c) 2015 Domenico Solazzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var numberField: UITextField!
    @IBOutlet weak var sliderValue: UILabel!
    @IBOutlet weak var rightSwitch: UISwitch!
    @IBOutlet weak var leftSwitch: UISwitch!
    @IBOutlet weak var doSomething: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        sliderValue.text = "50"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    @IBAction func textfieldDoneEditing(sender: UITextField) {
        sender.resignFirstResponder()
    }

    @IBAction func backgroundTap(sender: UIControl) {
        nameField.resignFirstResponder()
        numberField.resignFirstResponder()
    }

    @IBAction func sliderChanged(sender: UISlider) {
        let progress = lroundf(sender.value)
        sliderValue.text = "\(progress)"
    }
    @IBAction func switchChanged(sender: UISwitch) {
        let setting = sender.on
        leftSwitch.setOn(setting, animated: true)
        rightSwitch.setOn(setting, animated: true)
    }
    @IBAction func toggleControls(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            leftSwitch.hidden = false
            rightSwitch.hidden = false
            doSomething.hidden = true
        } else {
            leftSwitch.hidden = true
            rightSwitch.hidden = true
            doSomething.hidden = false
        }
    }
    @IBAction func buttonPressed(sender: UIButton) {
        let controller = UIAlertController(title: "Are You Sure?",
            message:nil, preferredStyle: .ActionSheet)
        
        let yesAction = UIAlertAction(title: "Yes, I'm sure!",
            style: .Destructive, handler: { action in
                let msg = self.nameField.text.isEmpty
                    ? "You can breathe easy, everything went OK."
                    : "You can breathe easy, \(self.nameField.text),"
                    + " everything went OK."
                let controller2 = UIAlertController(
                    title:"Something Was Done",
                    message: msg, preferredStyle: .Alert)
                let cancelAction = UIAlertAction(title: "Phew!",
                    style: .Cancel, handler: nil)
                controller2.addAction(cancelAction)
                self.presentViewController(controller2, animated: true,
                    completion: nil)
        })
        
        let noAction = UIAlertAction(title: "No way!",
            style: .Cancel, handler: nil)
        
        controller.addAction(yesAction)
        controller.addAction(noAction)
        
        if let ppc = controller.popoverPresentationController {
            ppc.sourceView = sender
            ppc.sourceRect = sender.bounds
        }
        
        presentViewController(controller, animated: true, completion: nil)
    }
}

