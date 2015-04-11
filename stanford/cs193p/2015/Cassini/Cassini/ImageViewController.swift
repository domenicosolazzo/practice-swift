//
//  ImageViewController.swift
//  Cassini
//
//  Created by Domenico on 11.04.15.
//  License: MIT
//

import UIKit

class ImageViewController: UIViewController {
    
    private var imageView = UIImageView()
    
    private var image: UIImage?{
        get{
            return imageView.image
        }
        set{
            imageView.image = newValue
            // Expand the frame to fit
            imageView.sizeToFit()
        }
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        view.addSubview(imageView)
    }

}
