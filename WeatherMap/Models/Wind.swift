//
//  Wind.swift
//  WeatherMap
//
//  Created by SalemMacPro on 8.5.21.
//

import Foundation

struct Wind: Codable {
    let speed: Double
    let deg: Int
    
    static func emptyInit() -> Wind {
        return Wind(speed: 0.0, deg: 0)
    }
    static func getDeg(deg: Int) -> String {
        switch deg {
        case 0...90:    return "N"
        case 91...180:  return "E"
        case 181...270: return "S"
        case 271...360: return "W"
        default: return "?"
        }
    }
}
