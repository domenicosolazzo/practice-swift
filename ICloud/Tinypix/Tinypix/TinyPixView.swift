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
    
    //- MARK: Draw
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect)
    {
        if (document != nil) {
            let size = bounds.size
            if !CGSizeEqualToSize(size, lastSize) {
                lastSize = size
                calculateGridForSize(size)
            }
            
            for var row = 0; row < 8; row++ {
                for var column = 0; column < 8; column++ {
                    drawBlockAt(row: row, column: column)
                }
            }
        }
    }
    
    private func drawBlockAt(#row: Int, column: Int) {
        let startX = gridRect.origin.x + gap
            + (blockSize.width + gap) * (7 - CGFloat(column)) + 1
        let startY = gridRect.origin.y + gap
            + (blockSize.height + gap) * CGFloat(row) + 1
        
        let blockFrame = CGRectMake(startX, startY,
            blockSize.width, blockSize.height)
        let color = document.stateAt(row: row, column: column)
            ? UIColor.blackColor() : UIColor.whiteColor()
        
        color.setFill()
        tintColor.setStroke()
        let path = UIBezierPath(rect:blockFrame)
        path.fill()
        path.stroke()
    }
    
    
}
