//
//  ViewController.swift
//  Psychologist
//
//  Created by Domenico on 21.03.15.
//  Copyright (c) 2015 Domenico Solazzo. All rights reserved.
//

import UIKit

class PsychologistViewController: UIViewController {
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        if let hvc = segue.destinationViewController as? HappinessViewController{
            // Check if the identifier is set
            if let identifier = segue.identifier{
                switch identifier{
                case "sad": hvc.happiness = 0
                case "happy": hvc.happiness = 100
                default: hvc.happiness = 50
                }
            }
        }
    }


}

