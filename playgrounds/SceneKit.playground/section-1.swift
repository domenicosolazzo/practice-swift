// Playground: SceneKit

import Cocoa
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
XCPShowView("The Scene View", sceneView)

// Default lighting
sceneView.autoenablesDefaultLighting = true
