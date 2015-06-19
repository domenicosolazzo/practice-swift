//
//  SurveyTask.swift
//  ResearchKitDemo
//
//  Created by Domenico on 19/06/15.
//  Copyright (c) 2015 Domenico. All rights reserved.
//

import ResearchKit

public var SurveyTask: ORKOrderedTask{
    var steps = [ORKStep]()
    
    
    return ORKOrderedTask(identifier: "SurveyTask", steps: steps)
}
