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
    
    static func update(planeNode: SCNNode, from planeAnchor: ARPlaneAnchor, hidden: Bool) {
        planeNode.geometry = self.plane(from: planeAnchor, hidden: hidden)
        planeNode.position = self.position(from: planeAnchor)
    }
    
    static func update(planeNode: SCNNode, hidden: Bool) {
        planeNode.geometry?.materials.first?.diffuse.contents = hidden ? UIColor(white: 1, alpha: 0) : UIColor(red: 0, green: 0, blue: 1, alpha: 0.5)
    }
    
    private static func plane(from planeAnchor: ARPlaneAnchor, hidden: Bool) -> SCNGeometry {
        let plane = SCNBox(width: CGFloat(planeAnchor.extent.x), height: 0.005, length: CGFloat(planeAnchor.extent.z), chamferRadius: 0)
        
        let color = SCNMaterial()
        color.diffuse.contents = hidden ? UIColor(white: 1, alpha: 0) : UIColor(red: 0, green: 0, blue: 1, alpha: 0.5)
        plane.materials = [color]
        
        return plane
    }
    
    private static func position(from planeAnchor: ARPlaneAnchor) -> SCNVector3 {
        return SCNVector3Make(planeAnchor.center.x, -0.005, planeAnchor.center.z)
    }
}
