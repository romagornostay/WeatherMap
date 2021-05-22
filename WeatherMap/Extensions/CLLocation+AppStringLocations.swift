//
//  CLLocation.swift
//  WeatherMap
//
//  Created by SalemMacPro on 11.5.21.
//

import CoreLocation

extension BinaryFloatingPoint {
    var dms: (degrees: Int, minutes: Int, seconds: Int) {
        var seconds = Int(self * 3600)
        let degrees = seconds / Constants.Seconds.inOneGeographicDegree
        seconds = abs(seconds % Constants.Seconds.inOneGeographicDegree)
        return (degrees, seconds / 60, seconds % 60)
    }
}

extension CLLocation {
    var dms: String { latitude + " " + longitude }
    
    var latitude: String {
        let (degrees, minutes, seconds) = coordinate.latitude.dms
        return String(format: "%d°%d'%d\"%@", abs(degrees), minutes, seconds, degrees >= 0 ? "N" : "S")
    }
    var longitude: String {
        let (degrees, minutes, seconds) = coordinate.longitude.dms
        return String(format: "%d°%d'%d\"%@", abs(degrees), minutes, seconds, degrees >= 0 ? "E" : "W")
    }
}
