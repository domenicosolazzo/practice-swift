//
//  ConsentDocument.swift
//  ResearchKitDemo
//
//  Created by Domenico on 18/06/15.
//  Copyright (c) 2015 Domenico. All rights reserved.
//

import ResearchKit

public var ConsentDocument: ORKConsentDocument{

    let consentDocument =  ORKConsentDocument()
    consentDocument.title = "Example title"
    
    let consentSectionTypes: [ORKConsentSectionType] = [
        ORKConsentSectionType.DataGathering,
        ORKConsentSectionType.DataUse,
        ORKConsentSectionType.OnlyInDocument,
        ORKConsentSectionType.Overview,
        ORKConsentSectionType.Privacy,
        ORKConsentSectionType.StudySurvey,
        ORKConsentSectionType.StudyTasks,
        ORKConsentSectionType.TimeCommitment,
        ORKConsentSectionType.Withdrawing,
    ]
    return consentDocument
}
