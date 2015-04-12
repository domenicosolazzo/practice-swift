//
//  BezierPathsView.swift
//  DropIt
//
//  Created by Domenico on 12.04.15.
//  Copyright (c) 2015 Domenico Solazzo. All rights reserved.
//

import UIKit

class BezierPathsView: UIView {

    private var bezierPaths = [String:UIBezierPath]()
    
    func setPath(path:UIBezierPath?, named name:String){
        bezierPaths[name] = path
        setNeedsDisplay()
    }
    override func drawRect(rect: CGRect) {
        // Drawing code
    }

}
