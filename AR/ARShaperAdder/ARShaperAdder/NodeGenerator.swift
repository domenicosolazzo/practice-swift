//
//  NodeGenerator.swift
//  ARShaperAdder
//
//  Created by Domenico Solazzo on 8/22/17.
//  Copyright © 2017 Domenico Solazzo. All rights reserved.
//

import Foundation
import SceneKit
import ARKit

struct NodeGenerator {
    
    static func generateSphereInFrontOf(node: SCNNode) -> SCNNode {
        let radius = (0.02...0.06).random()
        let sphere = SCNSphere(radius: CGFloat(radius))
        
        let color = SCNMaterial()
        color.diffuse.contents = self.randomColor()
        sphere.materials = [color]
        
        let sphereNode = SCNNode(geometry: sphere)
        
        let position = SCNVector3(x: 0, y: 0, z: -1)
        sphereNode.position = node.convertPosition(position, to: nil)
        sphereNode.rotation = node.rotation
        
        return sphereNode
    }
    
    static func generateCubeInFrontOf(node: SCNNode, physics: Bool) -> SCNNode {
        let size = CGFloat((0.06...0.1).random())
        let box = SCNBox(width: size, height: size, length: size, chamferRadius: 0)
        
        let color = SCNMaterial()
        color.diffuse.contents = self.randomColor()
        box.materials = [color]
        
        let boxNode = SCNNode(geometry: box)
        
        let position = SCNVector3(x: 0, y: 0, z: -1)
        boxNode.position = node.convertPosition(position, to: nil)
        boxNode.rotation = node.rotation
        
        if physics {
            let physicsBody = SCNPhysicsBody(type: .dynamic, shape: SCNPhysicsShape(geometry: box, options: nil))
            physicsBody.mass = 1.25
            physicsBody.restitution = 0.25
            physicsBody.friction = 0.75
            physicsBody.categoryBitMask = CollisionTypes.shape.rawValue
            boxNode.physicsBody = physicsBody
        }
        
        return boxNode
    }
    
    private static func randomColor() -> UIColor {
        return UIColor(hue: CGFloat(drand48()), saturation: 1, brightness: 1, alpha: 1)
    }
    
    struct CollisionTypes : OptionSet {
        let rawValue: Int
        
        static let bottom  = CollisionTypes(rawValue: 1 << 0)
        static let shape = CollisionTypes(rawValue: 1 << 1)
    }
}
