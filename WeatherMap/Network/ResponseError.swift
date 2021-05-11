//
//  ResponseError.swift
//  WeatherMap
//
//  Created by SalemMacPro on 8.5.21.
//

import Foundation

enum ResponseError: Error {
    case requestFailed
    case responseUnsuccessful(statusCode: Int)
    case invalidData
    case jsonParsingFailure
    case invalidURL
}
