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
        
        let progressBar = UIProgressView(progressViewStyle: UIProgressViewStyle.bar)
        progressBar.center = view.center
        progressBar.progress = 1 / 2
        progressBar.trackTintColor = UIColor.blue
        progressBar.tintColor = UIColor.red
        
        self.view.addSubview(progressBar)
    }
}

