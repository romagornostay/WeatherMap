//
//  OpenWeatherMapAPI.swift
//  WeatherMap
//
//  Created by SalemMacPro on 8.5.21.
//

import Foundation

class OpenWeatherMapAPI {

    private let apiKey = "Tap_Here_APIKey"
    private let decoder = JSONDecoder()
    private let session: URLSession

//    private enum SuffixURL: String {
//        case currentWeather = "weather"
//        case forecastWeather = "forecast"
//    }
        
    private func baseUrl(name: String) -> URL {
        return URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(name)&appid=\(self.apiKey)")!
    }
        
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }

    convenience init() {
        self.init(configuration: .default)
    }
        
    private func getBaseRequest<T: Codable>(name: String, completion: @escaping (_ object: T?,_ error: Error?) -> ()) {
        
        let url = baseUrl(name: name)
        let request = URLRequest(url: url)
        
//        let config = URLSessionConfiguration.default
//        config.waitsForConnectivity = true
//        config.timeoutIntervalForResource = 60
        
        let task = session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let data = data {
                    guard let httpResponse = response as? HTTPURLResponse else {
                        completion(nil, ResponseError.requestFailed)
                        return
                    }
                    
                    if httpResponse.statusCode == 200 {
                        do {
                            let weather = try self.decoder.decode(T.self, from: data)
                            completion(weather, nil)
                        } catch let error {
                            completion(nil, error)
                        }
                    } else {
                        completion(nil, ResponseError.invalidData)
                    }
                } else if let error = error {
                    completion(nil, error)
                }
            }
        }
        task.resume()
    }
    
    func getCurrentWeather(name: String, completion: @escaping (CurrentWeather?, Error?) -> Void) {
        getBaseRequest(name: name) { (weather, error) in
            completion(weather, error)
        }
    }
}
