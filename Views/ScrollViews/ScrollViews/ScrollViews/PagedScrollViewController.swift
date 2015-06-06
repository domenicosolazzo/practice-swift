//
//  PagedScrollViewController.swift
//  ScrollViews
//
//  Created by Domenico on 06/06/15.
//  Copyright (c) 2015 Domenico. All rights reserved.
//

import UIKit

class PagedScrollViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var pageControl: UIPageControl!
    // It will hold all the images to display. 1 for page
    var pageImages: [UIImage] = []
    // It will hold instances of UIImageView to display each image on its respective page
    var pageViews: [UIImageView?] = []
}
