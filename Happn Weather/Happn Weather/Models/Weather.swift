//
//  Weather.swift
//  Happn Weather
//
//  Created by Aymen Ben Romdhane on 24/09/2019.
//  Copyright © 2019 Aymen Ben Romdhane. All rights reserved.
//

import Foundation

class Weather {
    
    var timestamp: Int?
    var temperature: Float?
    var minTemperature: Float?
    var maxTemperature: Float?
    var weatherMain: String?
    var weatherDescription: String?
    
    func temperatureInCelsius() -> Float? {
        if (temperature == nil) {
            return nil
        }
        return round(temperature! - 273.15)
    }
    
    func minTemperatureInCelsius() -> Float? {
        if (minTemperature == nil) {
            return nil
        }
        return round(minTemperature! - 273.15)
    }
    
    func maxTemperatureInCelsius() -> Float? {
        if (maxTemperature == nil) {
            return nil
        }
        return round(maxTemperature! - 273.15)
    }
    
    func date() -> Date? {
        if (timestamp == nil) {
            return nil
        }
        let ti = TimeInterval(timestamp!)
        return Date(timeIntervalSince1970: ti)
    }
    
    func dateString(format: String) -> String {
        if let date = date() {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = format
            return dateFormatter.string(from: date)
        }
        return ""
    }
    
}
