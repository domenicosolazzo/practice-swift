//
//  MyCollectionViewCell.swift
//  CollectionView using custom xib files
//
//  Created by Domenico Solazzo on 10/05/15.
//  License MIT
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageViewBackgroundImage: UIImageView!
    let allImages = [
        UIImage(named: "1"),
        UIImage(named: "2"),
        UIImage(named: "3")
    ]
}
