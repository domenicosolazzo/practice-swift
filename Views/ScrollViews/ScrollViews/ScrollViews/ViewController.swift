//
//  ViewController.swift
//  ScrollViews
//
//  Created by Domenico on 06/06/15.
//  Copyright (c) 2015 Domenico. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet var scrollView: UIScrollView!
    var imageView: UIImageView!
    
    override func viewDidLoad() {
        // Create a new image
        let image = UIImage(named: "photo1.png")!
        imageView = UIImageView(image: image)
        imageView.frame = CGRect(origin: CGPoint(x: 0, y: 0), size:image.size)
        scrollView.addSubview(imageView)
        
        // Tell the scroll view the size of the content contained within it, so that it knows how far it can scroll horizontally and vertically
        scrollView.contentSize = image.size
        
        // Setting up a gesture recognizer for the double-tap to zoom in. Zoom gestures is already included in the scrollView.
        let doubleTapRecognizer = UITapGestureRecognizer(target: self, action: "scrollViewDoubleTapped:")
        doubleTapRecognizer.numberOfTapsRequired = 2
        doubleTapRecognizer.numberOfTouchesRequired = 1
        scrollView.addGestureRecognizer(doubleTapRecognizer)
        
        // Minimum zoom scale for the scroll view
        let scrollViewFrame = scrollView.frame
        let scaleWidth = scrollViewFrame.size.width / scrollView.contentSize.width
        let scaleHeight = scrollViewFrame.size.height / scrollView.contentSize.height
        let minScale = min(scaleWidth, scaleHeight);
        scrollView.minimumZoomScale = minScale;
        
        scrollView.maximumZoomScale = 1.0
        scrollView.zoomScale = minScale;
        
        // Center the image within the scroll view
        centerScrollViewContents()
    }
    
    func centerScrollViewContents() {
        /**
        Slight annoyance with UIScrollView: if the scroll view content size is smaller than its bounds, then it sits at the top-left rather than in the center.
        */
        let boundsSize = scrollView.bounds.size
        var contentsFrame = imageView.frame
        
        if contentsFrame.size.width < boundsSize.width {
            contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0
        } else {
            contentsFrame.origin.x = 0.0
        }
        
        if contentsFrame.size.height < boundsSize.height {
            contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0
        } else {
            contentsFrame.origin.y = 0.0
        }
        
        imageView.frame = contentsFrame
    }
    // When the tap gesture detects double tap
    func scrollViewDoubleTapped(recognizer: UITapGestureRecognizer) {
        // Where the tap occurred within the image view. 
        let pointInView = recognizer.locationInView(imageView)
        
        // Calculate a zoom scale that’s zoomed in 150%, but capped at the maximum zoom scale
        var newZoomScale = scrollView.zoomScale * 1.5
        newZoomScale = min(newZoomScale, scrollView.maximumZoomScale)
        
        // Calculate a CGRect rectangle that you want to zoom in on
        let scrollViewSize = scrollView.bounds.size
        let w = scrollViewSize.width / newZoomScale
        let h = scrollViewSize.height / newZoomScale
        let x = pointInView.x - (w / 2.0)
        let y = pointInView.y - (h / 2.0)
        
        let rectToZoomTo = CGRectMake(x, y, w, h);
        
        //  Tell the scroll view to zoom in
        scrollView.zoomToRect(rectToZoomTo, animated: true)
    }
    
    // Which view should be made bigger and smaller when the scroll view is pinched.
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    // The scroll view will call this method after the user finishes zooming
    func scrollViewDidZoom(scrollView: UIScrollView) {
        centerScrollViewContents()
    }
    
}

