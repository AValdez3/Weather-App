//
//  WeatherData.swift
//  Weather App
//
//  Created by Avelardo Valdez on 8/4/20.
//  Copyright © 2020 Avelardo Valdez. All rights reserved.
//

import Foundation


struct WeatherData: Codable {
    var weather: [Weather]
    var main: Main
    var name: String
}
