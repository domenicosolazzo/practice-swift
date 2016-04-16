//
//  ForecastService.swift
//  Stormy
//
//  Created by Domenico on 16/04/16.
//  Copyright © 2016 Domenico Solazzo. All rights reserved.
//

import Foundation

struct ForecastService{
    var forecastAPIKey: String
    var forecastBaseURL:NSURL?
    
    init(apiKey: String){
        forecastAPIKey = apiKey
        forecastBaseURL = NSURL(string: "https://api.forecast.io/forecast/\(forecastAPIKey)/")
    }
    
    func getForecast(lat:Double, lang:Double, completion: (CurrentWeather? -> ())){
        if let forecastUrl = NSURL(string: "\(lat),\(lang)", relativeToURL: forecastBaseURL){
            let networkOperation = NetworkOperation(url: forecastUrl)
            
            networkOperation.downloadJSONFromURL{
                (let jsonDictionary) in
                let currentWeather = self.currentWeatherFromJson(jsonDictionary)
                completion(currentWeather)
            }
        }
    }
    
    func currentWeatherFromJson(jsonDictionary:[String:AnyObject]?) -> CurrentWeather?{
        if let currentWeatherDictionary = jsonDictionary?["currently"] as? [String:AnyObject]{
            return CurrentWeather(weatherDictionary: currentWeatherDictionary)
        }else{
            print("JSON is invalid. Impossible to retrieve the 'currently' key")
            return nil
        }
    }
}
