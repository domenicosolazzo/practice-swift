//
//  ImageViewController.swift
//  Cassini
//
//  Created by Domenico on 11.04.15.
//  Copyright (c) 2015 Domenico Solazzo. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    
    private var imageView = UIImageView()
    
    private var image: UImage?{
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
