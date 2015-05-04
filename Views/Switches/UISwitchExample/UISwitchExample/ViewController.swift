//
//  ViewController.swift
//  UISwitchExample
//
//  Created by Domenico Solazzo on 04/05/15.
//  License MIT
//

import UIKit

class ViewController: UIViewController {

    // UISwitch
    var uiSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Creating a switch
        uiSwitch = UISwitch(frame: CGRect(x: 100, y: 100, width: 0, height: 0))
        
        // Switch is changed
        uiSwitch.addTarget(self, action: "switchIsChanged", forControlEvents: UIControlEvents.ValueChanged)
        
        // Adding the subview
        self.view.addSubview(uiSwitch)
    }
    
    func switchIsChanged(sender: UISwitch){
        println("Sender is = \(sender)")
        
        if sender.on{
            println("The switch is turned on")
        } else {
            println("The switch is turned off")
        }
    }


}

