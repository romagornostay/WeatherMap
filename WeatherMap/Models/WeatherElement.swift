//
//  WeatherElement.swift
//  WeatherMap
//
//  Created by SalemMacPro on 8.5.21.
//

import Foundation

struct WeatherElement: Codable {
    let id: Int
    let main, description, icon: String

    
    
    static func emptyInit() -> WeatherElement {
        return WeatherElement(
            id: 0,
            main: "",
            description: "",
            icon: ""
        )
    }
}
