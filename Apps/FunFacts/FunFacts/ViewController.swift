//
//  ViewController.swift
//  FunFacts
//
//  Created by Domenico on 12/04/16.
//  Copyright © 2016 Domenico Solazzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var funFactLabel: UILabel!
    
    let FunFacts = ["never give up" ,
                    "the better we get to get better tha faster we get better" ,
                    "life will never stop for any one" ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        funFactLabel.text = FunFacts[0]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func showFunFact(sender: AnyObject) {
        funFactLabel.text = FunFacts[1]
    }
}

