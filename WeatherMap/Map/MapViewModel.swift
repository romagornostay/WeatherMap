//
//  MapViewModel.swift
//  WeatherMap
//
//  Created by SalemMacPro on 10.5.21.
//

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
    var onDidStartLoading: (() -> Void)?
    var onDidEndLoading: (() -> Void)?
    var onDidSetupCard: (() -> Void)?
    var onDidHideCard: (() -> Void)?
    
    func showWeather() {
        if let place = place {
            delegate?.showWeather(place: place)
        }
    }
    
    func findLocality(coordinate: CLLocationCoordinate2D) {
        onDidStartLoading?()
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        LocationManager.shared.resolveLocationName(with: location) { [weak self] result in
            switch result {
            case .success(let locality):
                self?.setLocationForCard(place: locality, coordinate: coordinate)
            case .failure(let error):
                print(error.localizedDescription)
                self?.onDidHideCard?()
            }
            self?.onDidEndLoading?()
        }
    }
    
    private func setLocationForCard(place: String, coordinate: CLLocationCoordinate2D) {
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        self.location = location
        self.place = place
        self.coordinate = location.dms
        onDidSetupCard?()
    }
    
    func cleanCard() {
        self.location = nil
        self.place = nil
        self.coordinate = nil
        onDidHideCard?()
    }
}

