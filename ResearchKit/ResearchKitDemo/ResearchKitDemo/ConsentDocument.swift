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
    
    return consentDocument
}
