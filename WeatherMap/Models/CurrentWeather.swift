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
    let sys: Sys
    let code: Int
    
    enum CodingKeys: String, CodingKey {
        case base, visibility, wind, clouds, sys, timezone, id, name
        case elements = "weather"
        case coordinate = "coord"
        case mainValue = "main"
        case date = "dt"
        case code = "cod"
    }
    
    static func emptyInit() -> CurrentWeather {
        return CurrentWeather(
            timezone: 0,
            id: 0,
            name: "",
            coordinate: Coordinate.emptyInit(),
            elements: [],
            base: "",
            mainValue: MainValue.emptyInit(),
            visibility: 0,
            wind: Wind.emptyInit(),
            clouds: Clouds.emptyInit(),
            date: 0,
            sys: Sys.emptyInit(),
            code: 0
        )
    }
}
