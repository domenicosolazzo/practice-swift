//
//  PageContentViewController.swift
//  PageViewControllerTutorial
//
//  Created by Domenico on 06/06/15.
//  Copyright (c) 2015 Domenico. All rights reserved.
//

import UIKit

class PageContentViewController: UIViewController {

    @IBOutlet weak var heading: UILabel!
    @IBOutlet weak var bkImageView: UIImageView!

    var pageIndex: Int?
    var titleText : String!
    var imageName : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bkImageView.image = UIImage(named: imageName)
        self.heading.text = self.titleText
        self.heading.alpha = 0.1
        UIView.animateWithDuration(1.0, animations: { () -> Void in
            self.heading.alpha = 1.0
        })
        
    }
}
