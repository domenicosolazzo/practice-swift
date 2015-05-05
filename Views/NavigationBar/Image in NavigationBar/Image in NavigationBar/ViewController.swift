//
//  ViewController.swift
//  Image in NavigationBar
//
//  Created by Domenico Solazzo on 05/05/15.
//  License MIT
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* Create an Image View to replace the Title View */
        let imageView = UIImageView(
            frame: CGRect(x: 0, y: 0, width: 100, height: 40))
        
        imageView.contentMode = .ScaleAspectFit
        
        let image = UIImage(named:"Logo")
        
        imageView.image = image
        
        /* Set the Title View */
        navigationItem.titleView = imageView
    }

}

