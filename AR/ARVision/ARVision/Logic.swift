//
//  Scene.swift
//  ARVision
//
//  Created by Domenico Solazzo on 8/24/17.
//  Copyright © 2017 Domenico Solazzo. All rights reserved.
//

import SpriteKit
import ARKit
import Vision

class Scene: SKScene {
    
    override func didMove(to view: SKView) {
        // Setup your scene here
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let sceneView = self.view as? ARSKView else {
            return
        }
        
        // Create anchor using the camera's current position
        if let currentFrame = sceneView.session.currentFrame {
            DispatchQueue.global(qos: .background).async {
                do {
                    // Let's create a new instance of the Inception V3 model
                    let model = try VNCoreMLModel(for: Inceptionv3().model)
                    // Create a VNCoreMLRequest with a completion handler
                    let request = VNCoreMLRequest(model: model, completionHandler: { (request, error) in
                        // Jump onto the main thread
                        DispatchQueue.main.async {
                            // Access the first result in the array after casting the array as a VNClassificationObservation array
                            guard let results = request.results as? [VNClassificationObservation], let result = results.first else {
                                print ("No results?")
                                return
                            }
                            
                            // Create a transform with a translation of 0.2 meters in front of the camera
                            var translation = matrix_identity_float4x4
                            translation.columns.3.z = -0.4
                            let transform = simd_mul(currentFrame.camera.transform, translation)
                            
                            // Add a new anchor to the session
                            let anchor = ARAnchor(transform: transform)
                            sceneView.session.add(anchor: anchor)
                        }
                    })
                    // Create a VNImageRequestHandler
                    let handler = VNImageRequestHandler(cvPixelBuffer: currentFrame.capturedImage, options: [:])
                    try handler.perform([request])
                }catch{
                    
                }
            }
            
        }
    }
}
