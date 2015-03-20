//
//  HappinessViewController.swift
//  Happiness
//
//  Created by Domenico on 19.03.15.
//  Copyright (c) 2015 Domenico Solazzo. All rights reserved.
//

import UIKit

class HappinessViewController: UIViewController {

    var happiness: Int = 50{ // 0 = very sad, 100 = estatic
        didSet{
            happiness = min(max(happiness, 0),100)
            println("happiness: \(happiness)")
            self.updateUI()
        }
    }
    func updateUI(){
    
    }
}
