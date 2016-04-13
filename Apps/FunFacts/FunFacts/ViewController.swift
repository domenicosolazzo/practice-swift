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
    
    let factBook = FactBook()
    let colorWheel = ColorWheel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        funFactLabel.text = factBook.randomFact()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func showFunFact(sender: AnyObject) {
        let color = colorWheel.randomColor()
        funFactLabel.text = factBook.randomFact()
        funFactLabel.tintColor = color
        view.backgroundColor = color
    }
}

