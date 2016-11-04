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
    var lastSize: CGSize = CGSize.zero
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
    
    fileprivate func commonInit() {
        calculateGridForSize(bounds.size)
    }
    
    fileprivate func calculateGridForSize(_ size: CGSize) {
        let space = min(size.width, size.height)
        gap = space/57
        let cellSide = gap * 6
        blockSize = CGSize(width: cellSide, height: cellSide)
        gridRect = CGRect(x: (size.width - space)/2, y: (size.height - space)/2,
            width: space, height: space)
    }
    
    //- MARK: Draw
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect)
    {
        if (document != nil) {
            let size = bounds.size
            if !size.equalTo(lastSize) {
                lastSize = size
                calculateGridForSize(size)
            }
            
            for row in 0 ..< 8 {
                for column in 0 ..< 8 {
                    drawBlockAt(row: row, column: column)
                }
            }
        }
    }
    
    fileprivate func drawBlockAt(#row: Int, _ column: Int) {
        let startX = gridRect.origin.x + gap
            + (blockSize.width + gap) * (7 - CGFloat(column)) + 1
        let startY = gridRect.origin.y + gap
            + (blockSize.height + gap) * CGFloat(row) + 1
        
        let blockFrame = CGRect(x: startX, y: startY,
            width: blockSize.width, height: blockSize.height)
        let color = document.stateAt(row: row, column: column)
            ? UIColor.blackColor() : UIColor.whiteColor()
        
        color.setFill()
        tintColor.setStroke()
        let path = UIBezierPath(rect:blockFrame)
        path.fill()
        path.stroke()
    }
    
    //- MARK: Touch events
    fileprivate func touchedGridIndexFromTouches(_ touches: NSSet) -> GridIndex {
        var result = GridIndex(row: -1, column: -1)
        let touch = touches.anyObject() as! UITouch
        var location = touch.location(in: self)
        if gridRect.contains(location) {
            location.x -= gridRect.origin.x
            location.y -= gridRect.origin.y
            result.column = Int(8 - (location.x * 8.0 / gridRect.size.width))
            result.row = Int(location.y * 8.0 / gridRect.size.height)
        }
        return result
    }
    
    fileprivate func toggleSelectedBlock() {
        if selectedBlockIndex.row != -1
            && selectedBlockIndex.column != -1 {
                document.toggleStateAt(row: selectedBlockIndex.row,
                    column: selectedBlockIndex.column)
                (document.undoManager.prepare(withInvocationTarget: document) as AnyObject)
                    .toggleStateAt(row: selectedBlockIndex.row,
                        column: selectedBlockIndex.column)
                setNeedsDisplay()
        }
    }
    
    override func touchesBegan(_ touches: Set<NSObject>, with event: UIEvent) {
        selectedBlockIndex = touchedGridIndexFromTouches(touches as NSSet)
        toggleSelectedBlock()
    }
    
    override func touchesMoved(_ touches: Set<NSObject>, with event: UIEvent) {
        let touched = touchedGridIndexFromTouches(touches as NSSet)
        if touched.row != selectedBlockIndex.row
            && touched.column != selectedBlockIndex.column {
                selectedBlockIndex = touched
                toggleSelectedBlock()
        }
    }
    
    
}
