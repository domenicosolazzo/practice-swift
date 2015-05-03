//
//  RootViewController.swift
//  Presidents
//
//  Created by Domenico on 26.04.15.
//  Copyright (c) 2015 Domenico Solazzo. All rights reserved.
//

import UIKit

class RootViewController: UINavigationController {
    override func traitCollectionDidChange(previousTraitCollection: UITraitCollection?) {
        let splitVC = viewControllers[0] as! UIViewController
        let newTraits = traitCollection
        if newTraits.horizontalSizeClass == .Compact
            && newTraits.verticalSizeClass == .Compact {
                let childTraits = UITraitCollection(horizontalSizeClass: .Regular)
                setOverrideTraitCollection(childTraits, forChildViewController: splitVC)
        } else {
            setOverrideTraitCollection(nil, forChildViewController: splitVC)
        }
    }
}
