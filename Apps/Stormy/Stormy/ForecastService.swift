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
    var forecastBaseURL:URL?
    
    init(apiKey: String){
        forecastAPIKey = apiKey
        forecastBaseURL = URL(string: "https://api.forecast.io/forecast/\(forecastAPIKey)/")
    }
    
    func getForecast(_ lat:Double, lang:Double, completion: @escaping ((CurrentWeather?) -> ())){
        if let forecastUrl = URL(string: "\(lat),\(lang)", relativeTo: forecastBaseURL){
            let networkOperation = NetworkOperation(url: forecastUrl)
            
            networkOperation.downloadJSONFromURL{
                (jsonDictionary) in
                let currentWeather = self.currentWeatherFromJson(jsonDictionary)
                completion(currentWeather)
            }
        }
    }
    
    func currentWeatherFromJson(_ jsonDictionary:[String:AnyObject]?) -> CurrentWeather?{
        if let currentWeatherDictionary = jsonDictionary?["currently"] as? [String:AnyObject]{
            return CurrentWeather(weatherDictionary: currentWeatherDictionary)
        }else{
            print("JSON is invalid. Impossible to retrieve the 'currently' key")
            return nil
        }
    }
}
