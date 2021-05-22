//
//  Temperature.swift
//  WeatherMap
//
//  Created by SalemMacPro on 16.5.21.
//

import Foundation

struct Temperature {
  static func celsius(_ temperatureInKelvin: Double) -> Int {
    return Int(temperatureInKelvin - Constants.ZeroCelsius.inKelvin)
  }
}
