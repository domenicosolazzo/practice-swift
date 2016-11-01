//
//  SKNode+Extra.swift
//  TextShooter
//
//  Created by Domenico on 01/05/15.
//  Copyright (c) 2015 Domenico. All rights reserved.
//

import Foundation
import SpriteKit

extension SKNode {
    func receiveAttacker(_ attacker: SKNode, contact: SKPhysicsContact) {
        // Default implementation does nothing
    }
    
    func friendlyBumpFrom(_ node: SKNode) {
        // Default implementation does nothing
    }
}
