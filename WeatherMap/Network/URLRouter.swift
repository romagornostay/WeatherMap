//
//  URLRouter.swift
//  WeatherMap
//
//  Created by SalemMacPro on 16.5.21.
//

import Foundation

enum URLRouter {
  
  case forWeather(_ place: String, key: String), forIcon(_ code: String)
  
  var scheme: String {
    switch self {
    case .forWeather, .forIcon: return "https"
    }
  }
  
  var host: String {
    switch self {
    case .forWeather: return "api.openweathermap.org"
    case .forIcon:    return "openweathermap.org"
    }
  }
  
  var path: String {
    switch self {
    case .forWeather:        return "/data/2.5/weather"
    case .forIcon(let code): return "/img/wn/\(code)@2x.png"
    }
  }
  
  var method: String {
    switch self {
    case .forWeather, .forIcon: return "GET"
    }
  }
  
  var queryItems: [URLQueryItem] {
    switch self {
    case .forWeather(let city, let key):
      return [URLQueryItem(name: "q", value: city), URLQueryItem(name: "appid", value: key)]
    case .forIcon:
      return [URLQueryItem]()
    }
  }
  
  func completed() -> URL? {
    var components = URLComponents()
    components.scheme = self.scheme
    components.host = self.host
    components.path = self.path
    components.queryItems = self.queryItems
    return components.url
  }
}
