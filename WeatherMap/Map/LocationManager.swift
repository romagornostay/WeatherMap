//
//  LocationManager.swift
//  WeatherMap
//
//  Created by SalemMacPro on 6.5.21.
//

import Foundation
import CoreLocation


class LocationManager: NSObject, CLLocationManagerDelegate {
    
    static let shared = LocationManager()
    let manager = CLLocationManager()
    let geocoder = CLGeocoder()
    var completion: ((CLLocation) -> Void)?
    
    public func getUserLocation(completion: @escaping ((CLLocation) -> Void)) {
        self.completion = completion
        manager.requestWhenInUseAuthorization()
        manager.delegate = self
        manager.startUpdatingLocation()
    }
    
    public func resolveLocationName(with location: CLLocation, completion: @escaping ((String?) -> Void)) {
        geocoder.reverseGeocodeLocation(location, preferredLocale: .current) { placemarks, error in
            guard let placemark = placemarks?.first, error == nil else { return }
            if let locality = placemark.locality {
                DispatchQueue.main.async {
                    completion(locality)
                }
            }
        }
    }
    
    public func findLocations(with query: String, completion: @escaping ((CLLocation?) -> Void)) {
        geocoder.geocodeAddressString(query) { placemarks, error in
            guard let placemark = placemarks?.first, error == nil else { return }
            if let location = placemark.location {
                DispatchQueue.main.async {
                    completion(location)
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        completion?(location)
        manager.stopUpdatingLocation()
    }
}
