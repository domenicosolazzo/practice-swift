//
//  ViewController.swift
//  Download an Image on a concurrent queue
//
//  Created by Domenico Solazzo on 12/05/15.
//  License MIT
//

import UIKit

class ViewController: UIViewController {
    override func viewDidAppear(_ animated: Bool) {
        // Printing the current thread and main queue
        print("Current queue: \(Thread.current)")
        print("Main queue: \(Thread.main)")
        
        // Get the concurrent queue
        print("Fetching the queue: DISPATCH_QUEUE_PRIORITY_DEFAULT")
        let queue = DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.default)
        // Sending a block object to the queue
        queue.async(execute: {[weak self] in
            
            var image: UIImage?
            
            queue.sync(execute: {
                print("Downloading the image...")
                print("Current queue: \(Thread.current)")
                // Download the picture here
                
                let urlAsString = "http://upload.wikimedia.org/wikipedia/commons/7/7e/Saturn_with_auroras.jpg"
                
                // Creating a NSURL
                let url = URL(string: urlAsString)
                // Creating the NSURLRequest
                let request = URLRequest(url: url!)
                
                // Image data
                do{
                    let imageData = try NSURLConnection.sendSynchronousRequest(request, returning: nil)
                    if imageData.count > 0{
                        image = UIImage(data: imageData)
                    }else{
                        print("No data could get downloaded from the URL")
                    }
                }catch{
                    print("Error downloading")
                }
                
            })
            
            DispatchQueue.main.sync(execute: {
                // Show the image in the UI
                print("Current queue: \(Thread.current)")
                if let theImage = image{
                    // Create the image view
                    let imageView = UIImageView(frame: self!.view.bounds)
                    imageView.contentMode = UIViewContentMode.scaleAspectFit
                    imageView.image = theImage
                    self!.view.addSubview(imageView)
                }
            })
        
        })
    }
}

