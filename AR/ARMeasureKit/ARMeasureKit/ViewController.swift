//
//  ViewController.swift
//  ARMeasureKit
//
//  Created by Domenico Solazzo on 8/21/17.
//  Copyright © 2017 Domenico Solazzo. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    private var distanceLabel = UILabel()
    private var trackingStateLabel = UILabel()
    private var startNode: SCNNode?
    private var endNode: SCNNode?
    
    var dragOnInfinitePlanesEnabled = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Adding tap gesture
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.handleTapGesture))
        view.addGestureRecognizer(tapGestureRecognizer)
        
        distanceLabel.text = "Distance: ?"
        distanceLabel.textColor = .red
        distanceLabel.frame = CGRect(x: 5, y: 5, width: 150, height: 25)
        view.addSubview(distanceLabel)
        
        trackingStateLabel.frame = CGRect(x: 5, y: 35, width: 300, height: 25)
        view.addSubview(trackingStateLabel)
        
        setupFocusSquare()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingSessionConfiguration()
        
        // Run the view's session
        sceneView.session.run(configuration)
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
    
    /**
     *   Calculating the distance using the Three-dimensional Euclidean distance formula
     *   Reference: https://en.wikipedia.org/wiki/Euclidean_distance
    **/
    func distance(startNode: SCNNode, endNode: SCNNode) -> Float {
        let vector = SCNVector3Make(startNode.position.x - endNode.position.x, startNode.position.y - endNode.position.y, startNode.position.z - endNode.position.z)
        // Scene units map to meters in ARKit.
        return sqrtf(vector.x * vector.x + vector.y * vector.y + vector.z * vector.z)
    }
    
    func getCurrentFrame() -> ARFrame? {
        guard let currentFrame = sceneView.session.currentFrame else {
            return nil
        }
        return currentFrame
    }
    
    /**
     * Reset the UI. It will reset both startNode and endNode and the distanceLabel
     * Check if the endNode has been set already before resetting...
    **/
    func resetUI(){
        // Reset
        if let endNode = endNode {
            // Reset
            startNode?.removeFromParentNode()
            self.startNode = nil
            endNode.removeFromParentNode()
            self.endNode = nil
            distanceLabel.text = "Distance = ?"
            return
        }
    }
    
    /**
     * Create a new SceneKit node with a sphere shape at a given position.
     **/
    func createAnchorNode() -> SCNNode{
        let sphere = SCNSphere(radius: 0.002)
        sphere.firstMaterial?.diffuse.contents = UIColor.blue
        sphere.firstMaterial?.lightingModel = .constant
        sphere.firstMaterial?.isDoubleSided = true
        let node = SCNNode(geometry: sphere)
        return node
    }
    
    /**
     * Create a new SceneKit node with a sphere shape at a given position.
    **/
    func createAnchorNodeAt(position: SCNVector3) -> SCNNode{
        let node = self.createAnchorNode()
        node.position = position
        return node
    }
    /**
     * Setting the node to either startNode or endNode
    **/
    func settingNode(node:SCNNode){
        if self.startNode != nil {
            self.endNode = node
        }else{
            self.startNode = node
        }
    }
    
    /**
     * Check if the start node has been already set
    **/
    func isStartNodeAvailable() -> Bool {
        if self.startNode != nil {
            return true
        }
        return false
    }
    
    /**
     * Check if the end node has been already set
     **/
    func isEndNodeAvailable() -> Bool {
        if self.endNode != nil {
            return true
        }
        return false
    }
    
    func createFormatter() -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.roundingMode = .ceiling
        formatter.maximumFractionDigits = 2
        
        return formatter
    }
    
    func calculateDistance(useEuclideanDistance: Bool) -> Float{
        if (useEuclideanDistance){
            return distance(startNode: self.startNode!, endNode: self.endNode!)
        }else{
            let vector = (self.startNode?.position)! - (self.endNode?.position)!
            return vector.length()
        }
    }
    
    func executeHitTest(){
        guard let currentFrame = self.getCurrentFrame() else {
            return
        }
        
        let planeHitTestResults = sceneView.hitTest(view.center, types: .existingPlaneUsingExtent)
        if let result = planeHitTestResults.first {
            let hitPosition = SCNVector3.positionFromTransform(result.worldTransform)
            // Create the node to add to the scene
            let node = self.createAnchorNodeAt(position: hitPosition)
            
            sceneView.scene.rootNode.addChildNode(node)
            self.settingNode(node: node)
            
            if self.isStartNodeAvailable() && self.isEndNodeAvailable() {
                let formatter = self.createFormatter()
                let distanceLength = self.calculateDistance(useEuclideanDistance: false)
                // Scene units map to meters in ARKit.
                distanceLabel.text = "Distance: " + formatter.string(from: NSNumber(value: distanceLength))! + " m"
            }
        }
        else {
            // Create a transform with a translation of 0.1 meters (10 cm) in front of the camera
            var translation = matrix_identity_float4x4
            translation.columns.3.z = -0.1
            // Add a node to the session
            let node = self.createAnchorNode()
            node.simdTransform = simd_mul(currentFrame.camera.transform, translation)
            sceneView.scene.rootNode.addChildNode(node)
            self.settingNode(node: node)
            
            if self.isStartNodeAvailable() && self.isEndNodeAvailable() {
                let distanceLength = self.calculateDistance(useEuclideanDistance: true)
                self.distanceLabel.text = String(format: "%.2f", distanceLength) + "m"
            }
        }
    }
    
    @objc func handleTapGesture(sender: UITapGestureRecognizer) {
        if sender.state != .ended {
            return
        }
        self.resetUI()
        self.executeHitTest()
    }

    // MARK: - ARSCNViewDelegate
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        DispatchQueue.main.async {
            self.updateFocusSquare()
        }
    }
    
    func session(_ session: ARSession, cameraDidChangeTrackingState camera: ARCamera) {
        switch camera.trackingState {
        case .notAvailable:
            trackingStateLabel.text = "Tracking not available"
            trackingStateLabel.textColor = .red
        case .normal:
            trackingStateLabel.text = "Tracking normal"
            trackingStateLabel.textColor = .green
        case .limited(let reason):
            switch reason {
            case .excessiveMotion:
                trackingStateLabel.text = "Tracking limited: excessive motion"
            case .insufficientFeatures:
                trackingStateLabel.text = "Tracking limited: insufficient features"
            case .none:
                trackingStateLabel.text = "Tracking limited"
            case .initializing:
                trackingStateLabel.text = "Tracking limited: initializing"
            }
            trackingStateLabel.textColor = .yellow
        }
    }
    
    // MARK: - Focus Square
    
    var focusSquare = FocusSquare()
    
    func setupFocusSquare() {
        focusSquare.unhide()
        focusSquare.removeFromParentNode()
        sceneView.scene.rootNode.addChildNode(focusSquare)
    }
    
    func updateFocusSquare() {
        let (worldPosition, planeAnchor, _) = worldPositionFromScreenPosition(view.center, objectPos: focusSquare.position)
        if let worldPosition = worldPosition {
            focusSquare.update(for: worldPosition, planeAnchor: planeAnchor, camera: sceneView.session.currentFrame?.camera)
        }
    }
    
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
