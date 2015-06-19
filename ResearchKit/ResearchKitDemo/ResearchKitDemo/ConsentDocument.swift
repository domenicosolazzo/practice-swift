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
    
    // Sections
    let consentSectionTypes: [ORKConsentSectionType] = [
        .Overview,
        .DataGathering,
        .Privacy,
        .DataUse,
        .TimeCommitment,
        .StudySurvey,
        .StudyTasks,
        .Withdrawing
    ]

    var consentSections: [ORKConsentSection] = consentSectionTypes.map{ consentSectionType in
        let consentSection = ORKConsentSection(type: consentSectionType)
        consentSection.summary = "If you wish to complete this study..."
        consentSection.content = "In this study you will be asked five (wait, no, three!) questions.You will also have your voice recorded for ten seconds."
        return consentSection
    }
    
    consentDocument.sections = consentSections
    
    // Signature
    consentDocument.addSignature(ORKConsentSignature(forPersonWithTitle: nil, dateFormatString: nil, identifier: "ConsentDocumentParticipantSignature"))
    return consentDocument
}
