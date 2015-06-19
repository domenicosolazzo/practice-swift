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
    
    // Instruction step
    var instructionStep = ORKInstructionStep(identifier: "InstructionStep")
    instructionStep.title = "The Three Questions"
    instructionStep.text = "Who would cross the Bridge of Death must answer me these questions three, ere the other side they see."
    //instructionStep.image = UIImage(named: "Image")
    
    steps += [instructionStep]
    
    //TODO: add name question
    
    //TODO: add 'what is your quest' question
    
    //TODO: add color question step
    
    //TODO: add summary step
    
    
    return ORKOrderedTask(identifier: "SurveyTask", steps: steps)
}
