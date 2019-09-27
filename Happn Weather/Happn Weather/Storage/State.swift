//
//  State.swift
//  Happn Weather
//
//  Created by Aymen Ben Romdhane on 24/09/2019.
//  Copyright © 2019 Aymen Ben Romdhane. All rights reserved.
//

import Foundation

class State {
    
    static let sharedInstance = State()
    
    var weatherSamples: [Weather] = []
    
    // This function is to group the samples by their date
    func groupedWeatherSamples() -> [[Weather]] {
        
        if (weatherSamples == nil || weatherSamples.count < 1) {
            return [[]]
        }
        
        // Helper variable to map the samples by their date
        var dict: [String:[Weather]] = [:]
        
        for ws in weatherSamples {
            let dateKey = ws.dateString(format: "YYYYMMdd")
            if (dict[dateKey] == nil || dict[dateKey]!.count < 1) {
                dict[dateKey] = []
            }
            dict[dateKey]?.append(ws)
        }
        
        var retval: [[Weather]] = []
        
        let sortedKeys = Array(dict.keys).sorted()
        for key in sortedKeys {
            retval.append(dict[key]!)
        }
        
        return retval
    }
    
}
