//
//  LocalizationConstants.swift
//  WeatherMap
//
//  Created by SalemMacPro on 16.5.21.
//

import Foundation


struct LocalizationConstants {
    
    struct Map {
        static let title = NSLocalizedString("MAP.TITLE", comment: "")
        static let backItem = NSLocalizedString("MAP.BACK.ITEM", comment: "")
        static let showWeather = NSLocalizedString("MAP.CARD.BUTTON", comment: "")
    }
    
    struct Weather {
        static let humidity = NSLocalizedString("HUMIDITY", comment: "")
        static let wind = NSLocalizedString("WIND", comment: "")
        static let windMeasurement = NSLocalizedString("WIND.MEASUREMENT", comment: "")
        static let pressure = NSLocalizedString("PRESSURE", comment: "")
        static let pressureMeasurement = NSLocalizedString("PRESSURE.MEASUREMENT", comment: "")
    }
    struct KeyError {
        static let title = NSLocalizedString("KEY.ERROR.TITLE", comment: "")
        static let subtitle = NSLocalizedString("KEY.ERROR.DESCRIPTION", comment: "")
    }
    
    struct NoInternet {
        static let title = NSLocalizedString("NO.INTERNET.TITLE", comment: "")
        static let subtitle = NSLocalizedString("NO.INTERNET.DESCRIPTION", comment: "")
    }
    
    struct SomethingWentWrong {
        static let title = NSLocalizedString("SOMETHING.WENT.WRONG.TITLE", comment: "")
        static let subtitle = NSLocalizedString("SOMETHING.WENT.WRONG.DESCRIPTION", comment: "")
    }
    
    struct RefreshButton {
        static let title = NSLocalizedString("REFRESH.BUTTON", comment: "")
    }
}


