//
//  TinyPixDocument.swift
//  Tinypix
//
//  Created by Domenico on 27.04.15.
//  Copyright (c) 2015 Domenico Solazzo. All rights reserved.
//

import UIKit

class TinyPixDocument: UIDocument {
    // 8x8 bitmap data
    private var bitmap: [UInt8] = []
    
    override init(fileURL url: NSURL) {
        bitmap = [0x01, 0x02, 0x04, 0x08, 0x10, 0x20, 0x40, 0x80]
        super.init(fileURL: url)
    }
    
    /// It grabs relevant byte from our array of bytes, and then does a bit shift and
    /// an AND operation to determine whether the specified bit was set, 
    /// returning true or false accordingly.
    func stateAt(#row: Int, column: Int) -> Bool {
        let rowByte = bitmap[row]
        let result = UInt8(1 << column) & rowByte
        return result != 0
    }
    
    func setState(state: Bool, atRow row: Int, column: Int) {
        var rowByte = bitmap[row]
        if state {
            rowByte |= UInt8(1 << column)
        } else {
            rowByte &= ~UInt8(1 << column)
        }
        bitmap[row] = rowByte
    }
    
    func toggleStateAt(#row: Int, column: Int) {
        let state = stateAt(row: row, column: column)
        setState(!state, atRow: row, column: column)
    }
}
