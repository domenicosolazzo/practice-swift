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
        // Check if the destination is a UIViewController
        var destination = segue.destinationViewController as? UIViewController
        // navCon should be a UINavigationController
        if let navCon = destination as? UINavigationController{
            destination = navCon.visibleViewController
        }
        
        if let hvc = destination as? HappinessViewController{
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

    @IBAction func nothing(sender: UIButton) {
    }

}

