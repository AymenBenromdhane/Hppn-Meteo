//
//  ApiManager.swift
//  Happn Weather
//
//  Created by Aymen Ben Romdhane on 24/09/2019.
//  Copyright © 2019 Aymen Ben Romdhane. All rights reserved.
//

import Foundation

class ApiManager {
    
    /**
     Download weather forecast data
     */
    
    class func getForecast(_ completionHandler: @escaping (Int, Error?) -> Void) {
        
        let apiKey = "2f13b39ce2f0c440da48135b89d4d139"
        
        let url = "http://api.openweathermap.org/data/2.5/forecast?q=Paris&APPID=\(apiKey)"
        
        HttpManager.sendGetRequest(url: url) { (json, error) -> Void in
            
            if (error == nil && json != nil) {
                // The parsed data looks good; let's save it in the
                // session variable now
                let weatherSamples = ApiManager.parseWeatherData(json: json!)
                
                State.sharedInstance.weatherSamples = weatherSamples
                
                completionHandler(200, nil)
                
            } else {
                completionHandler(-1, error)
            }
        }
        
    }
    
    class func parseWeatherData(json: Any) -> [Weather] {
        var weatherDataPoints: [Weather] = []
        
        if let dict = json as? NSDictionary {
            
            if let list = dict["list"] as? [[String:AnyObject]] {
                print(list)
                for a in list {
                    let weather = Weather()
                    
                    let main = a["main"] as? [String:AnyObject]
                    let weatherInfo = a["weather"] as? [[String:AnyObject]]
                    
                    weather.timestamp = a["dt"] as? Int
                    weather.temperature = main?["temp"] as? Float
                    weather.minTemperature = main?["temp_min"] as? Float
                    weather.maxTemperature = main?["temp_max"] as? Float
                    
                    if (weatherInfo != nil && weatherInfo!.count > 0) {
                        weather.weatherDescription = weatherInfo?[0]["description"] as? String
                        weather.weatherMain = weatherInfo?[0]["main"] as? String
                    }
                    
                    weatherDataPoints.append(weather)
                }
            }
            
        }
        
        return weatherDataPoints
    }
    
}
