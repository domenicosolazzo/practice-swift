//
//  CurrentWeather.swift
//  Stormy
//
//  Created by Domenico on 15/04/16.
//  Copyright © 2016 Domenico Solazzo. All rights reserved.
//

import Foundation

struct CurrentWeather{
    let temperature:Int?
    let humidity:Int?
    let precipProbability:Int?
    let summary:String?
    
    init(weatherDictionary:[String:AnyObject]){
        temperature = weatherDictionary["temperature"] as? Int
        if let humidityFloat = weatherDictionary["humidity"] as? Double {
            humidity = Int(humidityFloat * 100)
        }else{
            humidity = nil
        }
        
        
        if let precipProbabilityFloat = weatherDictionary["precipProbability"] as? Double{
            precipProbability = Int(precipProbabilityFloat * 100)
        }else{
            precipProbability = nil
        }
        summary = weatherDictionary["summary"] as? String
    }
}