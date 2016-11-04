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
    fileprivate var bitmap: [UInt8] = []
    
    override init(fileURL url: URL) {
        bitmap = [0x01, 0x02, 0x04, 0x08, 0x10, 0x20, 0x40, 0x80]
        super.init(fileURL: url)
    }
    
    /// It grabs relevant byte from our array of bytes, and then does a bit shift and
    /// an AND operation to determine whether the specified bit was set, 
    /// returning true or false accordingly.
    func stateAt(#row: Int, _ column: Int) -> Bool {
        let rowByte = bitmap[row]
        let result = UInt8(1 << column) & rowByte
        return result != 0
    }
    
    func setState(_ state: Bool, atRow row: Int, column: Int) {
        var rowByte = bitmap[row]
        if state {
            rowByte |= UInt8(1 << column)
        } else {
            rowByte &= ~UInt8(1 << column)
        }
        bitmap[row] = rowByte
    }
    
    func toggleStateAt(#row: Int, _ column: Int) {
        let state = stateAt(row: row, column: column)
        setState(!state, atRow: row, column: column)
    }
    
    //- MARK: UIDocument
    override func contentsForType(_ typeName: String, error outError: NSErrorPointer) -> AnyObject? {
        println("Saving document to URL \(fileURL)")
        let bitmapData = Data(bytes: UnsafePointer<UInt8>(bitmap), count: bitmap.count)
        return bitmapData as AnyObject?
    }
    
    override func loadFromContents(_ contents: AnyObject, ofType typeName: String,
        error outError: NSErrorPointer) -> Bool {
            println("Loading document from URL \(fileURL)")
            let bitmapData = contents as! Data
            (bitmapData as NSData).getBytes(UnsafeMutablePointer<UInt8>(mutating: bitmap), length: bitmap.count)
            return true
    }
}
