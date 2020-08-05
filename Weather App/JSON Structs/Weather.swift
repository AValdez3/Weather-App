//
//  Weather.swift
//  Weather App
//
//  Created by Avelardo Valdez on 8/4/20.
//  Copyright © 2020 Avelardo Valdez. All rights reserved.
//

import Foundation


struct Weather: Codable {
    var id: Int
    var main: String
    var description: String
    var icon: String
    
}
