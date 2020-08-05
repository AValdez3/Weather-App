//
//  WeatherInformation.swift
//  Weather App
//
//  Created by Avelardo Valdez on 8/4/20.
//  Copyright © 2020 Avelardo Valdez. All rights reserved.
//

import Foundation

struct WeatherInformation {
    
    var cityName = "Modesto"
    var temperature: Double = 0 {
        didSet {
            temperatureInCelsius = round(temperature - 273.15)
            temperatureInFahrenheit = round((9 / 5) * temperatureInCelsius + 32)
        }
    }
    var temperatureInCelsius = 40.0
    var temperatureInFahrenheit = 50.0
    var condition = "Sunny"
    var weatherConditionIcon = "" {
        didSet {
            weatherConditionIconUrl = URL(string: "https://openweathermap.org/img/wn/\(weatherConditionIcon)@2x.png")!
        }
    }
    
    var weatherConditionIconUrl: URL = URL(string: "https://openweathermap.org/img/wn/10d@2x.png")!
    
}
