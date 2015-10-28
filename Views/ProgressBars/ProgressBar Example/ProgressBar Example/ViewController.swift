//
//  ViewController.swift
//  ProgressBar Example
//
//  Created by Domenico Solazzo on 06/05/15.
//  License MIT
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let progressBar = UIProgressView(progressViewStyle: UIProgressViewStyle.Bar)
        progressBar.center = view.center
        progressBar.progress = 1 / 2
        progressBar.trackTintColor = UIColor.blueColor()
        progressBar.tintColor = UIColor.redColor()
        
        self.view.addSubview(progressBar)
    }
}

