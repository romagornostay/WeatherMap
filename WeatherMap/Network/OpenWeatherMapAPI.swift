//
//  OpenWeatherMapAPI.swift
//  WeatherMap
//
//  Created by SalemMacPro on 8.5.21.
//

import Foundation
import Alamofire


final class OpenWeatherMapAPI {
    
    private let apiKey = "Tap_Here_APIKey"
    private let decoder = JSONDecoder()
    private let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    private func getBaseRequest<T: Codable>(router: Router, completion: @escaping (Result<T, ResponseError>) -> ()) {
        guard let url = router.completed() else {
            completion(.failure(.keyError))
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = router.method

        
        let task = session.dataTask(with: urlRequest) { data, response, error in
            if let data = data {
                guard let httpResponse = response as? HTTPURLResponse else {
                    completion(.failure(.noInternet))
                    return
                }
                
                if httpResponse.statusCode == 200 {
                    do {
                        let weather = try self.decoder.decode(T.self, from: data)
                        DispatchQueue.main.async {
                            completion(.success(weather))
                        }
                    } catch  {
                        completion(.failure(.serverResponse))
                    }
                } else {
                    completion(.failure(.serverResponse))
                }
            } else  {
                completion(.failure(.serverResponse))
            }
            
        }
        task.resume()
    }
    
    func getCurrentWeather(for place: String, completion: @escaping (Result<CurrentWeather, ResponseError>) -> ()) {
        getBaseRequest(router: .forWeather(place, key: apiKey)) { (result: Result<CurrentWeather, ResponseError>) in
            completion(result)
        }
    }
}
