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
        let device: MTLDevice = MTLCreateSystemDefaultDevice()!
        
        // create command queue
        var commandQueue: MTLCommandQueue = device.makeCommandQueue()
        
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
        let newVertexFunction = newDefaultLibrary!.makeFunction(name: "myVertexShader")
        let newFragmentFunction = newDefaultLibrary!.makeFunction(name: "myFragmentShader")
        
        // Render the pipeline
        let pipelineDescriptor = MTLRenderPipelineDescriptor()
        pipelineDescriptor.vertexFunction = newVertexFunction
        pipelineDescriptor.fragmentFunction = newFragmentFunction
        // More format here: https://developer.apple.com/library/ios/documentation/Metal/Reference/MetalConstants_Ref/#//apple_ref/c/tdef/MTLPixelFormat
        pipelineDescriptor.colorAttachments[0].pixelFormat = MTLPixelFormat.bgra8Unorm
        
        // Render pipeline state from descriptor
        var pipelineState: MTLRenderPipelineState!
        pipelineState = device.newRenderPipelineStateWithDescriptor(pipelineDescriptor, completionHandler: nil)
        
        //prepare view with layer
        let  metalLayer = CAMetalLayer()
        metalLayer.device = device //set the device
        metalLayer.pixelFormat = .BGRA8Unorm
        metalLayer.frame = view.layer.frame
        view.layer.addSublayer(metalLayer)
        
        //get next drawable texture
        var drawable = metalLayer.nextDrawable()
        
        //create a render descriptor
        let renderPassDescriptor = MTLRenderPassDescriptor()
        
        renderPassDescriptor.colorAttachments[0].texture = drawable.texture //assign drawable texture
        
        renderPassDescriptor.colorAttachments[0].loadAction = .clear //clear with color on load
        
        renderPassDescriptor.colorAttachments[0].clearColor = MTLClearColor(red: 1.0,
            green: 1.0,
            blue: 0.0,
            alpha: 1.0) // specify color to clear it with
        
        //Command Buffer - get next available command buffer
        let commandBuffer = commandQueue.makeCommandBuffer()
        
        //create Encoder - converts code to machine language
        let renderEncoder:MTLRenderCommandEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: renderPassDescriptor)
        
        //provide pipelineState and vertexBuffer
        renderEncoder.setRenderPipelineState(pipelineState)
        renderEncoder.setVertexBuffer(vertexBuffer, offset: 0, at: 0)
        
        //drawing begin
        renderEncoder.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: 3, instanceCount: 1) //drawin
        
        //End drawing
        renderEncoder.endEncoding()
        
        //commit to view
        commandBuffer.presentDrawable(drawable)
        commandBuffer.commit()
    }
}
