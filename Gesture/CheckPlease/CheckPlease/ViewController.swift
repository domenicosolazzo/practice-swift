//
//  ViewController.swift
//  CheckPlease
//
//  Created by Domenico on 02/05/15.
//  Copyright (c) 2015 Domenico. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var imageView:UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let check = CheckMarkRecognizer(target: self, action: #selector(ViewController.doCheck(_:)))
        view.addGestureRecognizer(check)
        imageView.isHidden = true;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func doCheck(_ check: CheckMarkRecognizer) {
        imageView.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(2 * NSEC_PER_SEC)) / Double(NSEC_PER_SEC),
            execute: { self.imageView.isHidden = true })
    }

}

