//
//  ImageViewController.swift
//  Cassini
//
//  Created by Domenico on 11.04.15.
//  License: MIT
//

import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate {
    
    var imageURL: NSURL?{
        didSet{
            image = nil
            // Fetch the image if I am onscreen
            if view.window != nil{
                fetchImage()
            }
            
        }
    }
    
    private func fetchImage(){
        if let url = imageURL{
            // Get the QUEUE identifier
            let qos = Int(QOS_CLASS_USER_INITIATED.value)
            // Dispatch the queue
            dispatch_async(dispatch_get_global_queue(qos, 0)){ () -> Void in
                let imageData = NSData(contentsOfURL: url)
                // Need to dispatch the result to the main queue because we are modifying the UI
                dispatch_async(dispatch_get_main_queue()) { () -> Void in
                    // Checking if this url is the last requested url
                    if url == self.imageURL{
                        if imageData != nil{
                            self.image = UIImage(data: imageData!)
                        }else{
                            self.image = nil
                        }
                    }
                    
                }
                
            }
            
        }
    }
    
    @IBOutlet weak var scrollView: UIScrollView!{
        didSet{
            // Need to set the content size of the scroll view
            scrollView.contentSize = imageView.frame.size
            // Set the delegate for the scrollView
            scrollView.delegate = self
            // Set the zoom
            scrollView.minimumZoomScale = 0.3
            scrollView.maximumZoomScale = 1
        }
    }
    
    // ScrollView function from UIScrollViewDelegate
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    private var imageView = UIImageView()
    
    private var image: UIImage?{
        get{
            return imageView.image
        }
        set{
            imageView.image = newValue
            // Expand the frame to fit
            imageView.sizeToFit()
            // Set the content size of the scroll view
            scrollView?.contentSize = imageView.frame.size
           
        }
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        view.addSubview(imageView)
       
    }
    
    override func viewWillAppear(animated:Bool){
        super.viewWillAppear(animated)
        // If I was offscreen and the image has not been fetched before
        if image == nil{
            fetchImage()
        }
    }

}
