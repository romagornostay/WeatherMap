//
//  Router.swift
//  WeatherMap
//
//  Created by SalemMacPro on 16.5.21.
//

import Foundation

enum Router {
  
  case getWeather(place: String, key: String), getIcon(code: String)
  
  var scheme: String {
    switch self {
    case .getWeather, .getIcon: return "https"
    }
  }
  
  var host: String {
    switch self {
    case .getWeather: return "api.openweathermap.org"
    case .getIcon:    return "openweathermap.org"
    }
  }
  
  var path: String {
    switch self {
    case .getWeather:        return "/data/2.5/weather"
    case .getIcon(let code): return "/img/wn/\(code)@2x.png"
    }
  }
  
  var method: String {
    switch self {
    case .getWeather, .getIcon: return "GET"
    }
  }
  
  var queryItems: [URLQueryItem] {
    switch self {
    case .getWeather(let city, let key):
      return [URLQueryItem(name: "q", value: city),URLQueryItem(name: "appid", value: key)]
    case .getIcon:
      return [URLQueryItem]()
    }
  }
  
  func getURL() -> URL? {
    var components = URLComponents()
    components.scheme = self.scheme
    components.host = self.host
    components.path = self.path
    components.queryItems = self.queryItems
    return components.url
  }
}
