//
//  MapViewModel.swift
//  WeatherMap
//
//  Created by SalemMacPro on 10.5.21.
//

import Foundation
import CoreLocation
import MapKit

protocol MapViewModelDelegate: AnyObject {
    func showWeather(place: String)
}

final class MapViewModel {
    weak var delegate: MapViewModelDelegate?
    
    var place: String?
    
    var stringCoord: String?
    
    func showWeather() {
        if let place = place {
            delegate?.showWeather(place: place)
        }
    }
}
