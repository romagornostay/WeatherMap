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
            
    private let cityName = "London" // Milan City
    
    private var city: String?
    
    init(city: String?) {
      self.city = city
    }
    
    //init(){ getData() }
    
    
    func retry() {
        stateView = .loading
        
       getData()
    }
    
    func getData() {
        client.getCurrentWeather(name: cityName) { [weak self] (weather, error) in
            guard let ws = self else { return }
            if let currentWeather = weather {
                ws.currentWeather = currentWeather
                ws.stateView = .success
                print("\n2.---\n\(currentWeather)\n\n")
            } else {
                ws.stateView = .failed
            }
        }
        print("\n1.---\n\(currentWeather)\n\n")
    }
}
