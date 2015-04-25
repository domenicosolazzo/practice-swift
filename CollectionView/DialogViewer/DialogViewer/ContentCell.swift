//
//  ContentCell.swift
//  DialogViewer
//
//  Created by Domenico on 25.04.15.
//  Copyright (c) 2015 Domenico Solazzo. All rights reserved.
//

import UIKit

class ContentCell: UICollectionViewCell {
    var label: UILabel!
    var text: String!
    var maxWidth: CGFloat!
    
    class func sizeForContentString(s: String,
        forMaxWidth maxWidth: CGFloat) -> CGSize {
            return CGSizeZero
    }

}
