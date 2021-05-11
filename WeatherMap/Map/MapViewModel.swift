//
//  MapViewModel.swift
//  WeatherMap
//
//  Created by SalemMacPro on 10.5.21.
//

import Foundation
import CoreLocation
import MapKit


final class MapViewModel {
    
   // weak var delegate: MapViewModelDelegate?
    weak var coordinator: MapCoordinator?

    
    var city: String?
    
    var coordinate: CLLocationCoordinate2D?
    
    var stringCoord: String?
    
    func showWeather() {
        let city = "Moscow"
        coordinator?.showWeather(city: city)
    }
    
    func setupLocationManager() {
        
        LocationManager.shared.getUserLocation { [weak self] location in
            DispatchQueue.main.async {
                guard let strongSelf = self else { return }
                self?.coordinate = location.coordinate
                self?.stringCoord = location.dms
                strongSelf.findPlace(with: location)
            }
        }
    }
    
    func findPlace(with location: CLLocation) {
        
        LocationManager.shared.resolveLocationName(with: location) { [weak self] locationName in
           
            self?.city = locationName
            
        }
    }
    
    
    func updateSearchResults(text: String) {
        LocationManager.shared.findLocations(with: text) { [weak self] locations in
            DispatchQueue.main.async {
                
                self?.coordinate = locations.first?.coordinates?.coordinate
                self?.stringCoord = locations.first?.coordinates?.dms
                self?.city = locations.first?.title
                
                print(self?.city ?? "NIL")
                
            }
      }
    }
}
