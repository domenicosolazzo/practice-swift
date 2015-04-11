//
//  ViewController.swift
//  Cassini
//
//  Created by Domenico on 11.04.15.
//  License: MIT
//

import UIKit

class ViewController: UIViewController {

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Check if the destination ViewController is an ImageViewController
        if let ivc = segue.destinationViewController as? ImageViewController{
            // Check if the Segue identifier is not nil
            if let identifier = segue.identifier{
                switch identifier{
                    case "Earth":
                        ivc.imageURL = DemoURL.NASA.Earth
                        ivc.title  = "Earth"
                    case "Cassini":
                        ivc.imageURL = DemoURL.NASA.Cassini
                        ivc.title = "Cassini"
                    case "Saturn":
                        ivc.imageURL = DemoURL.NASA.Saturn
                        ivc.title = "Saturn"
                default:
                    break
                }
            }
        }
    }


}

