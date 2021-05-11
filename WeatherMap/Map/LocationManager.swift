//
//  LocationManager.swift
//  WeatherMap
//
//  Created by SalemMacPro on 6.5.21.
//

import Foundation
import CoreLocation

struct Location {
    let title: String
    let coordinates: CLLocation?
}

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    static let shared = LocationManager()
    
    let manager = CLLocationManager()
    
    let geocoder = CLGeocoder()
    
    var completion: ((CLLocation) -> Void)?
    
    var previousLocation: CLLocation?
    
    public func getUserLocation(completion: @escaping ((CLLocation) -> Void)) {
        self.completion = completion
        manager.requestWhenInUseAuthorization()
        manager.delegate = self
        manager.startUpdatingLocation()
    }
    
    public func resolveLocationName(with location: CLLocation, completion: @escaping ((String?) -> Void)) {
        geocoder.reverseGeocodeLocation(location, preferredLocale: .current) { (placemarks, error) in
            guard let placemark = placemarks?.first, error == nil else {
                completion(nil)
                return
            }
            print(placemark)
            let name = placemark.country ?? ""

            completion(name)
        }
    }
    public func findLocations(with query: String, completion: @escaping (([Location]) -> Void)) {
        geocoder.geocodeAddressString(query) { places, error in
            guard let places = places, error == nil else {
                completion([])
                return
            }
            let models: [Location] = places.compactMap { place in
                var name = ""
                if let locationName = place.name {
                    name += locationName
                }
                if let adminRegion = place.administrativeArea {
                    name += ", \(adminRegion)"
                }
//                if let locality = place.locality {
//                    name += ", \(locality)"
//                }
                if let country = place.country {
                    name += ", \(country)"
                }
                print("\n\(place)\n\n")
                
                let result = Location(title: name, coordinates: place.location)
                return result
            }
            completion(models)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        completion?(location)
        manager.stopUpdatingLocation()
    }
}
