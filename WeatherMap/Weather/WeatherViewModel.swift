//
//  WeatherViewModel.swift
//  WeatherMap
//
//  Created by SalemMacPro on 9.5.21.
//

import Foundation
import UIKit

final class WeatherViewModel {
    
    private let client = OpenWeatherMapAPI()
    var stateView = StateView.loading
    var updateView: (() -> ())?
    var currentWeather = CurrentWeather.emptyInit()
    var responseError: ResponseError?
    private let place: String
    
    init(place: String) {
        self.place = place
    }
    
    func retry() {
        stateView = .loading
        getData()
    }
    
    func getData() {
        client.getCurrentWeather(for: place) { [weak self] (result: Result<CurrentWeather, ResponseError>) in
            guard let self = self else { return }
            switch result {
            case .success(let weather):
                self.currentWeather = weather
                self.stateView = .success
                self.updateView?()
            case .failure(let responseError):
                self.responseError = responseError
                self.stateView = .failed
            }
        }
    }
}
