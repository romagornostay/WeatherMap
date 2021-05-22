//
//  CardinalDirection.swift
//  WeatherMap
//
//  Created by SalemMacPro on 21.5.21.
//

import Foundation

enum CardinalDirection: String {
    case N, E, S, W
   static func from(_ degree: Int) -> String {
        switch degree {
        case 0...90:    return CardinalDirection.N.rawValue
        case 91...180:  return CardinalDirection.E.rawValue
        case 181...270: return CardinalDirection.S.rawValue
        case 271...360: return CardinalDirection.W.rawValue
        default: return ""
        }
    }
}
