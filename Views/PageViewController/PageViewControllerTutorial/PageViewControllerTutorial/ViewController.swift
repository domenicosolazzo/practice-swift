//
//  ViewController.swift
//  PageViewControllerTutorial
//
//  Created by Domenico on 06/06/15.
//  Copyright (c) 2015 Domenico. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    let pageTitles = ["Title 1", "Title 2", "Title 3", "Title 4"]
    var images = ["long3.png","long4.png","long1.png","long2.png"]
    var count = 0
    var pageViewController : UIPageViewController!

}

