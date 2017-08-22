//
//  Scene.swift
//  PokemonGhost
//
//  Created by Domenico Solazzo on 8/21/17.
//  Copyright © 2017 Domenico Solazzo. All rights reserved.
//

import SpriteKit
import ARKit

class Scene: SKScene {
    let ghostsLabel = SKLabelNode(text:"Ghosts")
    let numberOfGhostsLabel = SKLabelNode(text: "0")
    var creationTime: TimeInterval = 0
    var ghostCount = 0 {
        didSet {
            self.numberOfGhostsLabel.text = "\(ghostCount)"
        }
    }
    
    // Kill sound for the ghost
    let killSound = SKAction.playSoundFileNamed("ghost", waitForCompletion: false)
    
    override func didMove(to view: SKView) {
        // Setup your scene here
        ghostsLabel.fontSize = 20
        ghostsLabel.fontName = "DevanagariSangamMN-Bold"
        ghostsLabel.color = .white
        ghostsLabel.position = CGPoint(x: 40, y: 50)
        addChild(ghostsLabel)
        
        numberOfGhostsLabel.fontSize = 30
        numberOfGhostsLabel.fontName = "DevanagariSangamMN-Bold"
        numberOfGhostsLabel.color = .white
        numberOfGhostsLabel.position = CGPoint(x: 40, y: 10)
        addChild(numberOfGhostsLabel)
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
            
            // Create a transform with a translation of 0.2 meters in front of the camera
            var translation = matrix_identity_float4x4
            translation.columns.3.z = -0.2
            let transform = simd_mul(currentFrame.camera.transform, translation)
            
            // Add a new anchor to the session
            let anchor = ARAnchor(transform: transform)
            sceneView.session.add(anchor: anchor)
        }
    }
    
    // Return a random Float between min and max
    func randomFloat(min: Float, max: Float) -> Float {
        return (Float(arc4random()) / 0xFFFFFFFF) * (max - min) + min
    }
    
    func createGhostAnchor(){
        guard let sceneView = self.view as? ARSKView else {
            return
        }
        
        // Define 360 degrees in radians
        let _360degrees = 2.0 * Float.pi
        
        /**
         *  Let’s create one random rotation matrix on the X-axis and one on the Y-axis.
         *  SCNMatrix4MakeRotation returns a matrix describing a rotation transformation.
         *  The result of SCNMatrix4MakeRotation is converted to a 4×4 matrix using the simd_float4x4 struct
        **/
        let rotateX = simd_float4x4(
            SCNMatrix4MakeRotation(_360degrees * randomFloat(min: 0.0, max: 1.0), 1, 0, 0))
        
        let rotateX = simd_float4x4(
            SCNMatrix4MakeRotation(_360degrees * randomFloat(min: 0.0, max: 1.0), 0, 1, 0))
        
        // Multiply the rotation matrices
        let rotation = simd_mul(rotateX, rotateY)
        
        // Translation matrix in the Z-axis with a random value between -1 and -2 meters
        var translation = matrix_identity_float4x4
        translation.columns.3.z = -1 - randomFloat(min: 0.0, max: 1.0)
        
        // Multiply the translation and rotation matrices
        let transform = simd_mul(rotation, translation)
        
        // Let's create an anchor
        let anchor = ARAnchor(transform: transform)
        // Add the anchor to the scene
        sceneView.session.add(anchor: anchor)
        
        // Increment the ghost counter
        ghostCount += 1
        
    }
}
