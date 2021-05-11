//
//  Wind.swift
//  WeatherMap
//
//  Created by SalemMacPro on 8.5.21.
//

import Foundation

struct Wind: Codable {
    let speed: Double
    let deg: Int?
    
    static func emptyInit() -> Wind {
        return Wind(speed: 0.0, deg: nil)
    }
}
