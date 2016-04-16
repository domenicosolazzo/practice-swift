//
//  CurrentWeather.swift
//  Stormy
//
//  Created by Domenico on 15/04/16.
//  Copyright © 2016 Domenico Solazzo. All rights reserved.
//

import Foundation

enum Icon: String {
    case ClearDay = "clear-day"
    case ClearNight = "clear-night"
    case Rain = "rain"
    case Snow = "snow"
    case Sleet = "sleet"
    case Wind = "wind"
    case Fog = "fog"
    case Cloudy = "cloudy"
    case PartlyCloudyDay = "partly-cloudy-day"
    case PartlyCloudyNight = "partly-cloudy-night"
}

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