//
//  ViewController.swift
//  ScrollView Example
//
//  Created by Domenico Solazzo on 06/05/15.
//  License MIT
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    var imageView: UIImageView!
    var scrollView: UIScrollView!
    var image = UIImage(named: "earth")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView = UIImageView(image: image)
        scrollView = UIScrollView(frame: view.bounds)
        
        if let theScrollView = scrollView{
            scrollView.addSubview(imageView)
            // Set the content size
            scrollView.contentSize = imageView.bounds.size
            scrollView.delegate = self
            
            view.addSubview(scrollView)
            
        }
    }
    
    //- MARK: UIScrollViewDelegate
    func scrollViewDidScroll(scrollView: UIScrollView){
        /* Gets called when user scrolls or drags */
        scrollView.alpha = 0.50
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView){
        /* Gets called only after scrolling */
        scrollView.alpha = 1
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView,
        willDecelerate decelerate: Bool){
            scrollView.alpha = 1
    }
}

