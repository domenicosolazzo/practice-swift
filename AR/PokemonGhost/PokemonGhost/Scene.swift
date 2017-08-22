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
        // Create the ghosts at a defined time interval
        if currentTime > creationTime {
            createGhostAnchor()
            creationTime = currentTime + TimeInterval(randomFloat(min: 3.0, max: 6.0))
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        
        // get the location of the touch in the AR scene
        let location = touch.location(in: self)
        
        // get the nodes at the location
        let hit = nodes(at: location)
        
        // Get the first node and check if it is a ghost
        if let node = hit.first {
            if node.name == "ghost" {
                // Group the fade out and sound actions
                let fadeOut = SKAction.fadeOut(withDuration: 0.5)
                let remove = SKAction.removeFromParent()
                let groupKillingActions = SKAction.group([fadeOut, killSound])
                // Create an action sequence
                let sequenceAction = SKAction.sequence([groupKillingActions, remove])
                // Excecute the actions
                node.run(sequenceAction)
                
                // Update the counter
                ghostCount -= 1
                
            }
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
        
        let rotateY = simd_float4x4(
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
