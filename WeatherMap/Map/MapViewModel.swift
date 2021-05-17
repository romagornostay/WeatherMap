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
    var coordinate: String?
    var location: CLLocation?
    var setupCard: (() -> Void)?
    var hideCard: (() -> Void)?
    
    func showWeather() {
        if let place = place {
            delegate?.showWeather(place: place)
        }
    }
    
//    func findLocation(text: String) {
//        LocationManager.shared.findLocations(with: text) { [weak self] location in
//            guard let location = location else { return }
//            self?.setLocationForCard(place: text, coordinate: location.coordinate)
//        }
//    }
    
    func findLocality(coordinate: CLLocationCoordinate2D) {
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        LocationManager.shared.resolveLocationName(with: location) { [weak self] locality in
            guard let locality = locality else {
                self?.cleanCard()
                return
                
            }
            self?.setLocationForCard(place: locality, coordinate: coordinate)
        }
    }
    
    private func setLocationForCard(place: String, coordinate: CLLocationCoordinate2D) {
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)

        self.location = location
        self.place = place
        self.coordinate = location.dms
        setupCard?()
    }
    func cleanCard() {
        self.location = nil
        self.place = nil
        self.coordinate = nil
        hideCard?()
    }
}

