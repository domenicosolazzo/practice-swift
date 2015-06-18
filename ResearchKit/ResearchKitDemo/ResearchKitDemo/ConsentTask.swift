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
    let signature = consentDocument.signatures!.first as! ORKConsentSignature
    let reviewConsentStep = ORKConsentReviewStep(identifier: "ConsentReviewStep", signature: signature, inDocument: consentDocument)
    reviewConsentStep.text = "Review consent!"
    reviewConsentStep.reasonForConsent = "Consent to join the study"
    steps += [reviewConsentStep]
    return ORKOrderedTask(identifier: "ConsentTask", steps: steps)
}
