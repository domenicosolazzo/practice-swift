//
//  RootViewController.swift
//  Presidents
//
//  Created by Domenico on 26.04.15.
//  Copyright (c) 2015 Domenico Solazzo. All rights reserved.
//

import UIKit

class RootViewController: UINavigationController {
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        let splitVC = viewControllers[0] 
        let newTraits = traitCollection
        if newTraits.horizontalSizeClass == .compact
            && newTraits.verticalSizeClass == .compact {
                let childTraits = UITraitCollection(horizontalSizeClass: .regular)
                setOverrideTraitCollection(childTraits, forChildViewController: splitVC)
        } else {
            setOverrideTraitCollection(nil, forChildViewController: splitVC)
        }
    }
}
