//
//  WeatherViewModel.swift
//  WeatherMap
//
//  Created by SalemMacPro on 9.5.21.
//

import UIKit

final class WeatherViewModel {
    private let client = OpenWeatherMapAPI()
    var onDidStartLoading: (() -> Void)?
    var onDidEndLoading: (() -> Void)?
    var onDidUpdateData: ((CurrentWeather) -> Void)?
    var onDidReceiveError: ((ResponseError) -> Void)?
    private let place: String
    
    init(place: String) {
        self.place = place
    }
    
    func loadWeather() {
        DispatchQueue.main.async {
            self.onDidStartLoading?() }
        client.getCurrentWeather(for: place) { [weak self] (result: Result<CurrentWeather, ResponseError>) in
            switch result {
            case .success(let weather):
                self?.onDidUpdateData?(weather)
            case .failure(let responseError):
                self?.onDidReceiveError?(responseError)
            }
            self?.onDidEndLoading?()
        }
    }
}
