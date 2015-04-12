//
//  DropItViewController.swift
//  DropIt
//
//  Created by Domenico on 12.04.15.
//  Copyright (c) 2015 Domenico Solazzo. All rights reserved.
//

import UIKit

class DropItViewController: UIViewController {

    @IBOutlet weak var gameView: UIView!
    
    var dropsPerRow = 10
    
    var dropSize: CGSize{
        let size = gameView.bounds.size.width / CGFloat(dropsPerRow)
        return CGSize(width: size, height: size)
    }

    @IBAction func drop(sender: UITapGestureRecognizer) {
    }
}
