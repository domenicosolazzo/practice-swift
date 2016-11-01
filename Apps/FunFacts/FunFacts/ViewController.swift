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
    @IBOutlet weak var btnShow: UIButton!
    
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


    @IBAction func showFunFact(_ sender: AnyObject) {
        let color = colorWheel.randomColor()
        funFactLabel.text = factBook.randomFact()
        btnShow.tintColor = color
        btnShow.setTitleColor(color, for: UIControlState())
        view.backgroundColor = color
    }
}

