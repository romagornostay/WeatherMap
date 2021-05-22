//
//  OpenWeatherMapAPI.swift
//  WeatherMap
//
//  Created by SalemMacPro on 8.5.21.
//

import Foundation
import Alamofire


final class OpenWeatherMapAPI {
    
    private let apiKey = "d705032f30dea9ca692f37a198a0f1f5"//"Tap_Here_APIKey"
    private let decoder = JSONDecoder()
    
    
    private func getBaseRequest<T: Codable>(router: URLRouter, completion: @escaping (Result<T, ResponseError>) -> ()) {
        guard let url = router.completed() else {
            DispatchQueue.main.async {
                completion(.failure(.keyError))
            }
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = router.method
        
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let _ = error {
                DispatchQueue.main.async {
                    completion(.failure(.noInternet))
                }
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                DispatchQueue.main.async {
                    completion(.failure(.serverResponse))
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(.serverResponse))
                }
                return
            }
            
            do {
                let weather = try self.decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(weather))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(.serverResponse))
                }
            }
            
        }
        task.resume()
    }
    
    func getCurrentWeather(for place: String, completion: @escaping (Result<CurrentWeather, ResponseError>) -> Void) {
        getBaseRequest(router: .forWeather(place, key: apiKey)) { (result: Result<CurrentWeather, ResponseError>) in
            completion(result)
        }
    }
}
