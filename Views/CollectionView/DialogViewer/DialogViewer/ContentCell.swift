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
    var text: String! {
        get {
            return label.text
        }
        set(newText) {
            label.text = newText
            var newLabelFrame = label.frame
            var newContentFrame = contentView.frame
            let textSize = type(of: self).sizeForContentString(newText,
                forMaxWidth: maxWidth)
            newLabelFrame.size = textSize
            newContentFrame.size = textSize
            label.frame = newLabelFrame
            contentView.frame = newContentFrame
        }
    }
    var maxWidth: CGFloat!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        label = UILabel(frame: self.contentView.bounds)
        label.isOpaque = false
        label.backgroundColor =
            UIColor(red: 0.8, green: 0.9, blue: 1.0, alpha: 1.0)
        label.textColor = UIColor.black
        label.textAlignment = .center
        /// The defaultFont() method is a type method of the ContentCell class.
        /// It calls the subclass’ override of defaultFont().
        /// A reference is needed to the subclass’s type object, which is given from self.dynamicType
        label.font = type(of: self).defaultFont()
        contentView.addSubview(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    class func sizeForContentString(_ s: String,
        forMaxWidth maxWidth: CGFloat) -> CGSize {
            let maxSize = CGSize(width: maxWidth, height: 1000)
            let opts = NSStringDrawingOptions.usesLineFragmentOrigin
            
            let style = NSMutableParagraphStyle()
            style.lineBreakMode = NSLineBreakMode.byCharWrapping
            let attributes = [NSFontAttributeName: self.defaultFont(),
                NSParagraphStyleAttributeName: style]
            
            let string = s as NSString
            let rect = string.boundingRect(with: maxSize, options: opts,
                attributes: attributes, context: nil)
            
            return rect.size

    }
    
    class func defaultFont() -> UIFont {
        // Preferred font for the body text
        return UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)
    }

}
