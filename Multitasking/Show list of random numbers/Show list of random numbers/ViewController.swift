//
//  ViewController.swift
//  Show list of random numbers
//
//  Created by Domenico Solazzo on 12/05/15.
//  License MIT
//

import UIKit

class ViewController: UIViewController {
    // Find the location of the file
    func findLocation() -> String?{
        /* Get the document folder(s) */
        let folders = NSSearchPathForDirectoriesInDomains(
            NSSearchPathDirectory.DocumentDirectory,
            NSSearchPathDomainMask.UserDomainMask,
            true)
    }
}

