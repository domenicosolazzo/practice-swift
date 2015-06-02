//
//  SuperDBColorCell.swift
//  SuperDB
//
//  Created by Domenico on 02/06/15.
//  Copyright (c) 2015 Domenico. All rights reserved.
//

import UIKit

class SuperDBColorCell: SuperDBEditCell {

    var colorPicker: UIColorPicker!
    var attributedColorString: NSAttributedString!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
