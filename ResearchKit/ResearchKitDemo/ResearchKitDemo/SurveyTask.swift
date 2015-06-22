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
    
    // Name question
    let nameAnswerFormat = ORKTextAnswerFormat(maximumLength: 20)
    nameAnswerFormat.multipleLines = false
    let nameQuestionStepTitle = "What is your name?"
    let nameQuestionStep = ORKQuestionStep(identifier: "NameQuestion", title: nameQuestionStepTitle, answer: nameAnswerFormat)
    steps += [nameQuestionStep]
    
    // What is your quest question
    let questQuestionStepTitle = "What is your quest?"
    let textChoices = [
        ORKTextChoice(text: "Create a ResearchKit App", value: 0),
        ORKTextChoice(text: "Seek the Holy Grail", value: 1),
        ORKTextChoice(text: "Find a shrubbery", value: 2)
    ]
    let questAnswerFormat: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormatWithStyle(.SingleChoice, textChoices: textChoices)
    let questQuestionStep = ORKQuestionStep(identifier: "TextChoiceQuestionStep", title: questQuestionStepTitle, answer: questAnswerFormat)
    steps += [questQuestionStep]
    
    // Summary
    let summaryStep = ORKCompletionStep(identifier: "SummaryStep")
    summaryStep.title = "Right. Off you go!"
    summaryStep.text = "That was easy!"
    steps += [summaryStep]
    
    
    return ORKOrderedTask(identifier: "SurveyTask", steps: steps)
}
