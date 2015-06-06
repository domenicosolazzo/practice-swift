//
//  PeekPagedScrollViewController.swift
//  ScrollViews
//
//  Created by Domenico on 06/06/15.
//  Copyright (c) 2015 Domenico. All rights reserved.
//

import UIKit

class PeekPagedScrollViewController: UIViewController {
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var pageControl: UIPageControl!
    
    var pageImages: [UIImage] = []
    var pageViews: [UIImageView?] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up the image you want to scroll & zoom and add it to the scroll view
        pageImages = [UIImage(named: "photo1.png")!,
            UIImage(named: "photo2.png")!,
            UIImage(named: "photo3.png")!,
            UIImage(named: "photo4.png")!,
            UIImage(named: "photo5.png")!]
        
        let pageCount = pageImages.count
        
        // Set up the page control
        pageControl.currentPage = 0
        pageControl.numberOfPages = pageCount
        
        // Set up the array to hold the views for each page
        for _ in 0..<pageCount {
            pageViews.append(nil)
        }
        
        // Set up the content size of the scroll view
        let pagesScrollViewSize = scrollView.frame.size
        scrollView.contentSize = CGSizeMake(pagesScrollViewSize.width * CGFloat(pageImages.count), pagesScrollViewSize.height)
        
        // Load the initial set of pages that are on screen
        loadVisiblePages()
    }
}
