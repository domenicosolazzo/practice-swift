//
//  MyCollectionViewCell.swift
//  Handling events in CollectionViews
//
//  Created by Domenico Solazzo on 11/05/15.
//  License MIT
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageViewBackgroundImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageViewBackgroundImage.backgroundColor = UIColor.clearColor()
        
        // Background color for the selected cell
        self.selectedBackgroundView = UIView(frame: bounds)
        self.selectedBackgroundView!.backgroundColor = UIColor.blueColor()
    }
    
    
}
