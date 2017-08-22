//
//  NodeGenerator.swift
//  ARPlaneDetection
//
//  Created by Domenico Solazzo on 8/22/17.
//  Copyright © 2017 Domenico Solazzo. All rights reserved.
//

import Foundation
import SceneKit
import ARKit

struct NodeGenerator {
    
    static func generatePlaneFrom(planeAnchor: ARPlaneAnchor, physics: Bool, hidden: Bool) -> SCNNode {
        let plane = self.plane(from: planeAnchor, hidden: hidden)
        
        let planeNode = SCNNode(geometry: plane)
        planeNode.position = self.position(from: planeAnchor)
        
        if physics {
            let body = SCNPhysicsBody(type: .kinematic, shape: SCNPhysicsShape(geometry: plane, options: nil))
            body.restitution = 0.0
            body.friction = 1.0
            planeNode.physicsBody = body
        }
        
        return planeNode
    }
}
