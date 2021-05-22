//
//  ResponseError.swift
//  WeatherMap
//
//  Created by SalemMacPro on 8.5.21.
//

import Foundation

enum ResponseError: Error {
    case keyError
    case serverResponse
    case noInternet
}
