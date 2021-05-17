//
//  Temperature.swift
//  WeatherMap
//
//  Created by SalemMacPro on 16.5.21.
//

import Foundation

struct Temperature {
  static func conversionToC(_ temperatureInK: Double) -> Int {
    return Int(temperatureInK - 273.15)
  }
}
