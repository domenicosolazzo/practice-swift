//
//  FactBook.swift
//  FunFacts
//
//  Created by Domenico on 12/04/16.
//  Copyright © 2016 Domenico Solazzo. All rights reserved.
//

import Foundation

struct FactBook{
    let factsArray = [
        "Never give up",
        "the better we get to get better tha faster we get better" ,
        "life will never stop for any one"
    ]
    
    
    func randomFact() -> String{
        let unsignedArrayCount = UInt32(factsArray.count);
        let randomNumber = Int(arc4random_uniform(unsignedArrayCount))
        let randomString = factsArray[randomNumber]
        return randomString;
    }
}
