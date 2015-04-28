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
   
}
