//
//  LocationManager.swift
//  WeatherMap
//
//  Created by SalemMacPro on 6.5.21.
//

import CoreLocation

enum Locality: Error {
    case errorLocation
    case errorName
}

final class LocationManager {
    static let shared = LocationManager()
    private let geocoder = CLGeocoder()
    
    func resolveLocationName(with location: CLLocation, completion: @escaping (Result<String,Locality>) -> Void) {
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            guard let placemark = placemarks?.first, error == nil, let locality = placemark.locality else {
                completion(.failure(.errorLocation))
                return
            }
            DispatchQueue.main.async {
                completion(.success(locality))
            }
        }
    }
    
    func findLocation(with query: String, completion: @escaping ((CLLocation?) -> Void)) {
        geocoder.geocodeAddressString(query) { placemarks, error in
            guard let placemark = placemarks?.first, error == nil else { return }
            if let location = placemark.location {
                DispatchQueue.main.async {
                    completion(location)
                }
            }
        }
    }
}
