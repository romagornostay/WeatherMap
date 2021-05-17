//
//  Pressure.swift
//  WeatherMap
//
//  Created by SalemMacPro on 17.5.21.
//

import Foundation

struct Pressure {
  static func mmHg(_ hPa: Int) -> Int {
    return Int(Double(hPa)*0.75)
  }
}
