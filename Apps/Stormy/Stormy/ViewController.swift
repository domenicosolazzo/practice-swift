//
//  ViewController.swift
//  Stormy
//
//  Created by Domenico on 15/04/16.
//  Copyright © 2016 Domenico Solazzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var currentHumidityLabel: UILabel!
    @IBOutlet weak var currentPrecipitationLabel: UILabel!
    @IBOutlet weak var currentWeatherIcon: UIImageView?
    @IBOutlet weak var currentSummary: UILabel!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    fileprivate var forecastApiKey = ""
    let coordinate: (lat:Double, lang:Double) = (37.8267, -122.423)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getApiKey()
        retrieveWeatherInfo()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getApiKey(){
        let env = ProcessInfo.processInfo.environment
        if let key = env["FORECAST_API_KEY"]{
            self.forecastApiKey = key
        }
        
    }
    
    @IBAction func refreshAction(_ sender: UIButton) {
        toggleRefreshIndicator(true)
        self.retrieveWeatherInfo()
    }
    
    func retrieveWeatherInfo(){
        let forecastService = ForecastService(apiKey: forecastApiKey)
        forecastService.getForecast(coordinate.lat, lang: coordinate.lang){
            (currently) in
            if let currentWeather = currently{
                // Update UI
                DispatchQueue.main.async{ // Go back to the main thread
                    self.toggleRefreshIndicator(false)
                    
                    if let temperature = currentWeather.temperature{
                        self.currentTemperatureLabel.text = "\(temperature)º"
                    }
                    
                    if let humidity = currentWeather.humidity{
                        self.currentHumidityLabel.text = "\(humidity)%"
                    }
                    
                    if let precipProbability = currentWeather.precipProbability{
                        self.currentPrecipitationLabel.text = "\(precipProbability)%"
                    }
                    
                    if let icon = currentWeather.icon{
                        self.currentWeatherIcon?.image = icon
                    }
                    
                    if let summary = currentWeather.summary{
                        self.currentSummary.text = summary
                    }
                    
                }
            }
        }
    }
    
    func toggleRefreshIndicator(_ on:Bool){
        refreshButton.isHidden = on
        if on {
            activityIndicator.startAnimating()
        }else{
            activityIndicator.stopAnimating()
        }
    }


}

