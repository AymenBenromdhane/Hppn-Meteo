//
//  SampleViewCell.swift
//  Happn Weather
//
//  Created by Aymen Ben Romdhane on 26/09/2019.
//  Copyright © 2019 Aymen Ben Romdhane. All rights reserved.
//

import UIKit

class SampleViewCell : UICollectionViewCell {
    
    @IBOutlet weak var weatherMainLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var minTemperatureLabel: UILabel!
    @IBOutlet weak var maxTemperatureLabel: UILabel!
    @IBOutlet weak var hourLabel: UILabel!
    
    var weatherSample: Weather?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 8.0
    }
    
    func setWeatherSample(weatherSample: Weather) {
        self.weatherSample = weatherSample
        
        weatherMainLabel.text = weatherSample.weatherMain
        weatherDescriptionLabel.text = weatherSample.weatherDescription
        
        if (weatherSample.temperatureInCelsius() != nil) {
            temperatureLabel.text = "\(weatherSample.temperatureInCelsius()!) °C"
        }
        if (weatherSample.minTemperatureInCelsius() != nil) {
            minTemperatureLabel.text = "\(weatherSample.minTemperatureInCelsius()!) °C"
        }
        if (weatherSample.maxTemperatureInCelsius() != nil) {
            maxTemperatureLabel.text = "\(weatherSample.maxTemperatureInCelsius()!) °C"
        }
        
        hourLabel.text = weatherSample.dateString(format: "HH:mm")
    }
    
}
