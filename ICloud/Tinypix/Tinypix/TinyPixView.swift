//
//  TinyPixView.swift
//  Tinypix
//
//  Created by Domenico on 28/04/15.
//  Copyright (c) 2015 Domenico Solazzo. All rights reserved.
//

import UIKit

struct GridIndex {
    var row: Int
    var column: Int
}

class TinyPixView: UIView {
    var document: TinyPixDocument!
    var lastSize: CGSize = CGSizeZero
    var gridRect: CGRect!
    var blockSize: CGSize!
    var gap: CGFloat = 0
    var selectedBlockIndex: GridIndex = GridIndex(row: NSNotFound, column: NSNotFound)
   
    //- MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        calculateGridForSize(bounds.size)
    }
    
    private func calculateGridForSize(size: CGSize) {
        let space = min(size.width, size.height)
        gap = space/57
        let cellSide = gap * 6
        blockSize = CGSizeMake(cellSide, cellSide)
        gridRect = CGRectMake((size.width - space)/2, (size.height - space)/2,
            space, space)
    }
}
