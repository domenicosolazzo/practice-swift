//
//  ImageViewController.swift
//  Cassini
//
//  Created by Domenico on 11.04.15.
//  License: MIT
//

import UIKit

class ImageViewController: UIViewController {
    
    private var imageURL: NSURL?{
        didSet{
            image = nil
            fetchImage()
        }
    }
    
    private func fetchImage(){
        if let url = imageURL{
            // Very bad:it can take long time to retrieve the data
            let imageData = NSData(contentsOfFile: url)
            if imageData != nil{
                image = UIIMage(data: imageData)
            }else{
                image = nil
            }
        }
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
        }
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        view.addSubview(imageView)
    }

}
