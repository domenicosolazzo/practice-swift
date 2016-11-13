//
//  BlueViewController.swift
//  ViewSwitcher
//
//  Created by Domenico on 20.04.15.
//  Copyright (c) 2015 Domenico Solazzo. All rights reserved.
//

import UIKit

class BlueViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func blueButtonPressed(_ sender: UIButton) {
        let alert = UIAlertController(title: "Blue View Button Pressed",
            message: "You pressed the button on the blue view",
            preferredStyle: .alert)
        let action = UIAlertAction(title: "Yep, I did", style: .default,
            handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

}
