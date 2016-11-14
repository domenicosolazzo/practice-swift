// Playground: SceneKit
// Source: http://goo.gl/DvsBPi
// Use a OSX playground

import UIKit
import PlaygroundSupport
import SceneKit
import QuartzCore // for the basic animation
import XCPlayground // for the live preview

// create a scene view with an empty scene
var sceneView = SCNView(frame:CGRect(x:0, y:0, width:300, height:300))
// New scene
var scene = SCNScene()
// Connect the scene to the view
sceneView.scene = scene

// Start a live preview of the scene
PlaygroundPage.current.liveView = sceneView

// Default lighting
sceneView.autoenablesDefaultLighting = true

// Camera
var camera = SCNCamera()
var cameraNode = SCNNode()
cameraNode.camera = camera
cameraNode.position = SCNVector3(x:0, y:0, z:3)
// Connect the camera to the scene
scene.rootNode.addChildNode(cameraNode)

// Geometry object
var torus = SCNTorus(ringRadius: 1, pipeRadius: 0.35)
var torusNode = SCNNode(geometry: torus)
// Connect the object to the scene
scene.rootNode.addChildNode(torusNode)

// Configure the geometry object
torus.firstMaterial?.diffuse.contents = UIColor.red
torus.firstMaterial?.specular.contents = UIColor.white

// animate the rotation of the torus
var spin = CABasicAnimation(keyPath: "rotation")
spin.toValue = NSValue(scnVector4: SCNVector4(x: 1, y: 1, z: 0, w: Float(2.0) * Float(M_PI)))
spin.duration = 3
spin.repeatCount = HUGE // for infinity
torus.addAnimation(spin,forKey: "spin aroud")


