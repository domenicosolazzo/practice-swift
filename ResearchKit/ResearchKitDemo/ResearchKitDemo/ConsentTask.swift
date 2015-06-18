//
//  ConsentTask.swift
//  ResearchKitDemo
//
//  Created by Domenico on 18/06/15.
//  Copyright (c) 2015 Domenico. All rights reserved.
//

import ResearchKit

public var ConsentTask:ORKOrderedTask{
    var steps = [ORKStep]()
    
    // Visual Step
    var consentDocument = ConsentDocument
    let visualContentStep = ORKVisualConsentStep(identifier: "VisualContentStep", document: consentDocument)
    steps += [visualContentStep]
    
    // Review step
    
    return ORKOrderedTask(identifier: "ConsentTask", steps: steps)

}
