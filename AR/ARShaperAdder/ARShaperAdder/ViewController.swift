//
//  ViewController.swift
//  ARShaperAdder
//
//  Created by Domenico Solazzo on 8/22/17.
//  Copyright © 2017 Domenico Solazzo. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        sceneView.automaticallyUpdatesLighting = true
        sceneView.autoenablesDefaultLighting = true
        sceneView.antialiasingMode = .multisampling4X
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        if ARWorldTrackingConfiguration.isSupported {
            let configuration = ARWorldTrackingConfiguration()
            self.sceneView.session.run(configuration)
        } else if ARConfiguration.isSupported {
            let configuration = ARSessionConfiguration()
            self.sceneView.session.run(configuration)
        }

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    @IBAction func tapScreen() {
        if let camera = self.sceneView.pointOfView {
            let sphere = NodeGenerator.generateSphereInFrontOf(node: camera)
            self.sceneView.scene.rootNode.addChildNode(sphere)
            print("Added sphere to scene")
        }
    }
    
    @IBAction func twoFingerTapScreen() {
        if let camera = self.sceneView.pointOfView {
            let sphere = NodeGenerator.generateCubeInFrontOf(node: camera, physics: false)
            self.sceneView.scene.rootNode.addChildNode(sphere)
            print("Added cube to scene")
        }
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
