//
//  Coordinate.swift
//  WeatherMap
//
//  Created by SalemMacPro on 8.5.21.
//

import Foundation

struct Coordinate: Codable {
    let lon, lat: Double
    
    static func emptyInit() -> Coordinate {
        return Coordinate(lon: 0, lat: 0)
    }
}
