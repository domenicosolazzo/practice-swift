//
//  GameViewController.swift
//  metalexample
//
//  Created by Domenico on 14/07/15.
//  Copyright (c) 2015 Domenico Solazzo. All rights reserved.
//

import UIKit
import Metal
import QuartzCore



class GameViewController: UIViewController {
    
    override func viewDidLoad() {
        // get device
        let device: MTLDevice = MTLCreateSystemDefaultDevice()
        
        // create command queue
        var commandQueue: MTLCommandQueue = device.newCommandQueue()
        
        // Vertex
        let vertexArray:[Float] = [
            
            0.0, 0.75,
            
            -0.75, -0.75,
            
            0.75, -0.75]
        
        // Vertex buffer
        var vertexBuffer: MTLBuffer! = device.newBufferWithBytes(vertexArray,
            length: vertexArray.count * sizeofValue(vertexArray[0]),
            options: nil)
    }
}