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
        
        // Get the shader
        let newDefaultLibrary = device.newDefaultLibrary()
        let newVertexFunction = newDefaultLibrary!.newFunctionWithName("myVertexShader")
        let newFragmentFunction = newDefaultLibrary!.newFunctionWithName("myFragmentShader")
        
        // Render the pipeline
        let pipelineDescriptor = MTLRenderPipelineDescriptor()
        pipelineDescriptor.vertexFunction = newVertexFunction
        pipelineDescriptor.fragmentFunction = newFragmentFunction
        // More format here: https://developer.apple.com/library/ios/documentation/Metal/Reference/MetalConstants_Ref/#//apple_ref/c/tdef/MTLPixelFormat
        pipelineDescriptor.colorAttachments[0].pixelFormat = MTLPixelFormat.BGRA8Unorm
        
        // Render pipeline state from descriptor
        var pipelineState: MTLRenderPipelineState!
        pipelineState = device.newRenderPipelineStateWithDescriptor(pipelineDescriptor, error: nil)
        
        //prepare view with layer
        let  metalLayer = CAMetalLayer()
        metalLayer.device = device //set the device
        metalLayer.pixelFormat = .BGRA8Unorm
        metalLayer.frame = view.layer.frame
        view.layer.addSublayer(metalLayer)
    }
}