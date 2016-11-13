//
//  ViewController.swift
//  Switch in the NavigationBar
//
//  Created by Domenico Solazzo on 06/05/15.
//  License MIT
//

import UIKit

class ViewController: UIViewController {

    func switchChangedValue(_ sender: UISwitch){
        if sender.isOn{
            print("Switching off")
        }else{
            print("Switching on")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let simpleSwitch = UISwitch()
        simpleSwitch.isOn = true
        
        simpleSwitch.addTarget(self,
            action: #selector(ViewController.switchChangedValue(_:)),
            for: UIControlEvents.valueChanged)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            customView: simpleSwitch)
        
    }
}

