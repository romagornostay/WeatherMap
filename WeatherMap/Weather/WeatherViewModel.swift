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
    
    var currentWeather = CurrentWeather.emptyInit()
    
    private let place: String
    
    init(place: String) {
        self.place = place
    }
     
    
    func retry() {
        stateView = .loading
        
        getData()
    }
    
    func getData() {
        client.getCurrentWeather(name: place) { [weak self] (weather, error) in
            guard let cw = self else { return }
            if let currentWeather = weather {
                cw.currentWeather = currentWeather
                cw.stateView = .success
                print("\n2.---\n\(currentWeather)\n\n")
            } else {
                cw.stateView = .failed
            }
        }
        print("\n1.---\n\(currentWeather)\n\n")
    }
    
    func sendData() -> CurrentWeather {
        let cw = self.currentWeather
       return cw
    }
}
