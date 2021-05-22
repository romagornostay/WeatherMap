//
//  System.swift
//  WeatherMap
//
//  Created by SalemMacPro on 8.5.21.
//

import Foundation

struct System: Codable {
    let type, id: Int
    let country: String
    let sunrise, sunset: Int
}
