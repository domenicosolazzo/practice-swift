//
//  FlickrPhotoCell.swift
//  FlickrSearch
//
//  Created by Domenico on 03/06/15.
//  Copyright (c) 2015 Domenico. All rights reserved.
//

import UIKit

class FlickrPhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.isSelected = false
    }
    override var isSelected : Bool {
        didSet {
            self.backgroundColor = isSelected ? themeColor : UIColor.black
        }
    }
}
