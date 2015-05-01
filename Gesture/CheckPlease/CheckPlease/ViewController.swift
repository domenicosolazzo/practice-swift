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
        let check = CheckMarkRecognizer(target: self, action: "doCheck:")
        view.addGestureRecognizer(check)
        imageView.hidden = true;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func doCheck(check: CheckMarkRecognizer) {
        imageView.hidden = false
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(2 * NSEC_PER_SEC)),
            dispatch_get_main_queue(),
            { self.imageView.hidden = true })
    }

}

