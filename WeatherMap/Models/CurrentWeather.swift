//
//  CurrentWeather.swift
//  WeatherMap
//
//  Created by SalemMacPro on 8.5.21.
//

import Foundation

struct CurrentWeather: Codable {
    let timezone, id: Int
    let name: String
    let coordinate: Coordinate
    let elements: [WeatherElement]
    let base: String
    let mainValue: MainValue
    let visibility: Int
    let wind: Wind
    let clouds: Clouds
    let date: Int
    let sys: System
    let code: Int
    
    enum CodingKeys: String, CodingKey {
        case base, visibility, wind, clouds, sys, timezone, id, name
        case elements = "weather"
        case coordinate = "coord"
        case mainValue = "main"
        case date = "dt"
        case code = "cod"
    }
}
