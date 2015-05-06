//
//  ViewController.swift
//  Switch in the NavigationBar
//
//  Created by Domenico Solazzo on 06/05/15.
//  License MIT
//

import UIKit

class ViewController: UIViewController {

    func switchChangedValue(sender: UISwitch){
        if sender.on{
            println("Switching off")
        }else{
            println("Switching on")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var simpleSwitch = UISwitch()
        simpleSwitch.on = true
        
        simpleSwitch.addTarget(self,
            action: "switchChangedValue:",
            forControlEvents: UIControlEvents.ValueChanged)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            customView: simpleSwitch)
        
    }
}

