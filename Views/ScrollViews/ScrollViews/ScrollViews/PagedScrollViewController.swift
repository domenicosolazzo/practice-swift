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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set up the page images
        pageImages = [UIImage(named: "photo1.png")!,
            UIImage(named: "photo2.png")!,
            UIImage(named: "photo3.png")!,
            UIImage(named: "photo4.png")!,
            UIImage(named: "photo5.png")!]
        
        let pageCount = pageImages.count
        
        // set the page control to the first page and tell it how many pages there are.
        pageControl.currentPage = 0
        pageControl.numberOfPages = pageCount
        
        // Set up the array that holds the UIImageView instances. At first, no pages have been lazily loaded and so you just fill it with nil objects as placeholders – one for each page
        for _ in 0..<pageCount {
            pageViews.append(nil)
        }
        
        // The scroll view, as before, needs to know its content size. Since you want a horizontal paging scroll view (it could just as easily be vertical if you want), you calculate the width to be the number of pages multiplied by the width of the scroll view. The height of the content is the same as the height of the scroll view.
        let pagesScrollViewSize = scrollView.frame.size
        scrollView.contentSize = CGSize(width: pagesScrollViewSize.width * CGFloat(pageImages.count),
            height: pagesScrollViewSize.height)
        
        // need some pages shown initially
    }
}
