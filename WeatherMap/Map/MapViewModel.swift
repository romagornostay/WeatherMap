//
//  MapViewModel.swift
//  WeatherMap
//
//  Created by SalemMacPro on 10.5.21.
//

import Foundation
import CoreLocation
import MapKit

protocol MapViewModelDelegate: class {
  func showWeather(place: String)
}


final class MapViewModel {
    
    var place: String?
    
    
    func showWeather() {
      if let place = place {
        //delegate?.showWeather(place: place)
      }
    }

}
