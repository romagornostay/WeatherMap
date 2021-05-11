//
//  Clouds.swift
//  WeatherMap
//
//  Created by SalemMacPro on 8.5.21.
//

import Foundation

struct Clouds: Codable {
    let all: Int

    static func emptyInit() -> Clouds {
        return Clouds(all: 0)
    }
}
