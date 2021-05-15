//
//  OpenWeatherMapAPI.swift
//  WeatherMap
//
//  Created by SalemMacPro on 8.5.21.
//

import Foundation
import Alamofire

enum NetworkError: Error {
    case keyError
    case serverResponse
    case noInternet
}

class OpenWeatherMapAPI {
    
    private let apiKey = "d705032f30dea9ca692f37a198a0f1f5"//"Tap_Here_APIKey"
    private let decoder = JSONDecoder()
    private let session: URLSession
    
    
    func responseStreamDecodable<T: Decodable>(of type: T.Type = T.self,
                                               on queue: DispatchQueue = .main,
                                               using decoder: DataDecoder = JSONDecoder(),
                                               preprocessor: DataPreprocessor = PassthroughPreprocessor(),
                                               stream: Result<T, AFError>) -> Self{
        return self
    }
    
    
    private func getBaseReques<T: Codable>(router: Router, on queue: DispatchQueue = .main, stream: @escaping (Result<T, NetworkError>) -> ()) {
        guard let url = router.getURL() else {
            stream(.failure(.keyError))
            return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = router.method
        
        AF.streamRequest(urlRequest).validate(statusCode: 200...200).responseStreamDecodable(of: T.self) { stream in
            switch stream.event {
            case let .stream(result):
                switch result {
                case let .success(value):
                    print(value)
                case let .failure(error):
                    print(error)
                }
            case let .complete(completion):
                print(completion)
            }
        }

    }
    func getCurrentWeathe(place: String, completion: @escaping (Result<CurrentWeather, NetworkError>) -> ()) {
        
        getBaseReques(router: .getWeather(place: place, key: apiKey)) { (result: Result<CurrentWeather, NetworkError>) in
            completion(result)
        }
    }
    
    
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
    
    private func getBaseRequest<T: Codable>(router: Router, completion: @escaping (_ object: T?,_ error: Error?) -> ()) {
        guard let url = router.getURL() else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = router.method
//        let url = baseUrl(name: name)
//        let request = URLRequest(url: url)
        
        //        let config = URLSessionConfiguration.default
        //        config.waitsForConnectivity = true
        //        config.timeoutIntervalForResource = 60
        
        let task = session.dataTask(with: urlRequest) { data, response, error in
            if let data = data {
                guard let httpResponse = response as? HTTPURLResponse else {
                    completion(nil, ResponseError.requestFailed)
                    return
                }
                
                if httpResponse.statusCode == 200 {
                    do {
                        let weather = try self.decoder.decode(T.self, from: data)
                        DispatchQueue.main.async {
                        completion(weather, nil)
                        }
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
        task.resume()
    }
    
    func getCurrentWeather(name: String, completion: @escaping (CurrentWeather?, Error?) -> Void) {
        getBaseRequest(router: .getWeather(place: name, key: apiKey)) { (weather, error) in
            completion(weather, error)
        }
    }
}
