//
//  WeatherViewModelProtocols.swift
//  WeatherMap
//
//  Created by SalemMacPro on 11.5.21.
//

import Foundation
import UIKit

protocol WeatherViewModelProtocol {
    var currentWeather: CurrentWeather { get set }
    
    func getData()
}
